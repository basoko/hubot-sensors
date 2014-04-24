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

  it 'registers a respond listener for "sensors list"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensors list$/i)

  it 'registers a respond listener for "sensors list enabled"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensors list enabled$/i)

  it 'registers a respond listener for "sensors list disabled"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensors list disabled/i)

  it 'registers a respond listener for "sensors enable"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensors enable (.*)/i)

  it 'registers a respond listener for "sensors disable"', ->
    expect(@robot.respond).to.have.been.calledWith(/sensors disable (.*)/i)
