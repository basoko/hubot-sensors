HubotSensor = require('../sensor')

class WeatherSensor extends HubotSensor
  constructor: (@robot) ->
    super(60 * 60 * 1000, false)

  check: () ->
    true

  fire: () ->
    weather = @_getWeather()

  _getWeather: () ->
    @robot.http("http://api.openweathermap.org/data/2.5/forecast/daily?q=bilbao&cnt=1&mode=json")
    .get() (err, res, body) =>
      if err
        "Encountered an error #{err}"

      data = JSON.parse(body)
      degrees = Math.round((data.list[0].temp.day - 273.15) * 100) / 100
      humidity = data.list[0].humidity

      @notify "The weather in #{data.city.name} is #{degrees}°C with a humidity of #{humidity}%"

module.exports = WeatherSensor
