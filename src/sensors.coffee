# Description:
#   Hubot sensors to give you information
#
# Dependencies:
#
# Configuration:
#   HUBOT_SENSORS_FOLDER - Folder of the sensors to be loaded
#
# Commands:
#   hubot sensor list           - List of loaded sensors
#   hubot sensor list enabled   - List of enabled sensors
#   hubot sensor list disabled  - List of disabled sensors
#   hubot sensor enable (.*)    - Enable a disabled sensor
#
# Author:
#   basoko
#

path = require('path')

module.exports = (robot) ->

  class HubotSensorsManager
    SENSORS_STORE = {}
    DEFAULT_SENSORS_FOLDER = 'sensors'
    this.add = (sensor) ->
      robot.logger.debug "Adding sensor..."
      SENSORS_STORE[sensor.name()] = sensor

    this.remove = (sensor) ->
      robot.logger.debug "Remove"
      delete SENSORS_STORE[sensor.name()]

    this.list = () ->
      list = []
      list.push sensor for name, sensor of SENSORS_STORE
      list

    this.get = (name) ->
      SENSORS_STORE[name]

    this._loadSensors = () ->
      this._loadDefaultSensors()
      this._loadUserSensors()

    this._loadDefaultSensors = () ->
      this._loadSensorsFolder path.resolve __dirname, DEFAULT_SENSORS_FOLDER

    this._loadUserSensors = () ->
      userSensors = process.env.HUBOT_SENSORS_FOLDER
      if userSensors
        robot.logger.debug "Loading user sensors..."
        this._loadSensorsFolder path.resolve userSensors
      else
        robot.logger.warning "The HUBOT_SENSORS_FOLDER environment variable not set"

    this._loadSensorsFolder = (folder) ->
      robot.logger.debug "Loading sensors folder: #{folder}"

      require("fs").readdirSync(folder).forEach((file) =>
        filename = file.split('.')[0]
        if filename is 'sensor'
          return

        this._loadSensor path.resolve(folder, filename)
      )

    this._loadSensor = (file) ->
      robot.logger.debug "Loading sensor from file: #{file}"

      Sensor = require(file)
      sensor = new Sensor robot

      this.add sensor

  HubotSensorsManager._loadSensors()

  robot.respond /sensor list$/i, (msg) ->
    response = 'Current list of sensors:\n'
    response += "#{sensor.name()}\t\t#{sensor.info()}\n" for sensor in HubotSensorsManager.list()

    msg.send response

  robot.respond /sensor list enabled$/i, (msg) ->
    response = 'Enabled sensors:\n'
    response += "#{sensor.name()}\t\t#{sensor.info()}\n" for sensor in HubotSensorsManager.list() when sensor.isActive()
    msg.send response

  robot.respond /sensor list disabled/i, (msg) ->
    response = 'Disabled sensors:\n'
    response += "#{sensor.name()}\t\t#{sensor.info()}\n" for sensor in HubotSensorsManager.list() when not sensor.isActive()

    msg.send response

  robot.respond /sensor enable (.*)/i, (msg) ->
    sensor = HubotSensorsManager.get msg.match[1]
    sensor?.enable()

  robot.respond /sensor disable (.*)/i, (msg) ->
    sensor = HubotSensorsManager.get msg.match[1]
    sensor?.disable()
