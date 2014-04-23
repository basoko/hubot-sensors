chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

expect = chai.expect

describe 'sensors', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
      logger:
        debug: sinon.spy()
        info: sinon.spy()
        warning: sinon.spy()

    require('../src/sensors.coffee')(@robot)

  it 'registers a respond listener for "sensor list"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensor list$/i)

  it 'registers a respond listener for "sensor list enabled"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensor list enabled$/i)

  it 'registers a respond listener for "sensor list disabled"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensor list disabled/i)

  it 'registers a respond listener for "sensor enable"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensor enable (.*)/i)

  it 'registers a respond listener for "sensor disable"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensor disable (.*)/i)
