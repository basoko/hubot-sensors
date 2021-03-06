path = require('path')

class HubotSensor
  constructor: (@freq, active = true) ->
    @_id = null
    @room = process.env.HUBOT_SENSORS_ROOM

    @setup() if active

  setup: () ->
    @enable()

  check: () ->

  fire: () ->

  notify: (text, rooms = [@room]) ->
    @robot.messageRoom(room, text) for room in [].concat rooms

  name: () ->
    @constructor.name

  info: () ->
    "Info of #{@constructor.name}"

  enable: () ->
    @_id = setInterval @_loop, @freq

  disable: () ->
    clearInterval @_id
    @_id = null

  isActive: () ->
    @_id?

  _loop: () =>
    @fire() if @check()


module.exports = HubotSensor
