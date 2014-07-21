require '../helper'

describe 'list-pr', ->
  beforeEach (done) ->
    @kakashi.scripts = [require '../../src/scripts/list-pr']
    @kakashi.users = [{ id: 'bouzuya', room: 'hitoridokusho' }]
    @kakashi.start().then done, done

  afterEach (done) ->
    @kakashi.stop().then done, done

  describe 'receive "@hubot list-pr hitoridokusho/hibot"', ->
    beforeEach ->
      {pullRequests} = require 'github/api/v3.0.0/pullRequests'
      @sinon.stub pullRequests, 'getAll', (msg, block, callback) ->
        callback(null, [
          title: 'hoge'
          url: 'https://github.com/hitoridokusho/hibot/pulls/1'
        ])
      GitHub = require 'github'
      @sinon.stub GitHub.prototype, 'authenticate', -> # do nothing

    it 'send "hoge\\n  https://github.com/hitoridokusho/hibot/pulls/1"',
      (done) ->
        sender = id: 'bouzuya', room: 'hitoridokusho'
        message = '@hubot list-pr hitoridokusho/hibot'
        @kakashi
          .receive sender, message
          .then =>
            expect(@kakashi.send.callCount).to.equal(1)
            expect(@kakashi.send.firstCall.args[1]).to
              .equal('hoge\n  https://github.com/hitoridokusho/hibot/pulls/1')
          .then (-> done()), done
