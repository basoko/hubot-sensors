# hubot-sensors

A hubot script to create and manage hubot sensors.

[![Build Status](https://api.travis-ci.org/basoko/hubot-sensors.png?branch=master)](https://travis-ci.org/basoko/hubot-sensors)

## Setup

Create in your hubot location a directory to put there your sensors.

    $ mkdir my_sensors

Then set the environment variable HUBOT_SENSORS_FOLDER to this folder created before.

    $ export HUBOT_SENSORS_FOLDER="./mysensors"

Now, set the environment variable HUBOT_SENSORS_ROOM to use this chat room for your sensor's notifications.

    $ export HUBOT_SENSORS_ROOM="sensors-warnings"

You'll need to add this as a dependency to your hubot:

    $ npm install --save hubot-sensors

Lastly add it to the list of external dependencies in `external-scripts.json`:

    ["hubot-sensors"]

## How to create your own sensors
Basically, you should create a file in your sensor's folder that should export your sensor class.
This class has to extend the HubotSensor class implementing the check and fire methods.

The check method should return a boolean value, maybe based on some condition, to indicate that your sensor should be fired. Whereas, the fire method should do your own logic, for example sending a message to the room indicating that there is something wrong (using the sensor's notify method).

Finally, from your sensor's constructor you should invoke to the parent's constructor (super method) passing the frecuency time, in miliseconds, that your sensor will be checked, and an optional boolean parameter to indicate if the sensor should be activated when is loaded.

In the default_sensors folder your will find some examples that can help you to implement your own sensors.

## Current commands

    sensors list - List all sensors loaded
    sensors list enabled - List all sensors enabled
    sensors list disabled - List all sensors disabled
    sensors enable <sensor_name> - Enable the sensor requested
    sensors disable <sensor_name> - Enable the sensor requested

## Example
    hubot sensors list

Will output:

    Current list of sensors:
    WeatherSensor    	Info of WeatherSensor
