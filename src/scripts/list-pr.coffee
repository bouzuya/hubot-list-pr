# Description
#   list-pr
#
# Dependencies:
#   "github": "^0.2.1",
#   "q": "^1.0.1"
#
# Configuration:
#   HUBOT_LIST_PR_TOKEN
#
# Commands:
#   hubot list-pr <user>/<repo> - list Pull Requests
#
# Author:
#   bouzuya <m@bouzuya.net>
#
{Promise} = require 'q'
GitHub = require 'github'

module.exports = (robot) ->

  listPullRequests = (user, repo) ->
    new Promise (resolve, reject) ->
      github = new GitHub version: '3.0.0'
      github.authenticate
        type: 'oauth'
        token: process.env.HUBOT_LIST_PR_TOKEN
      github.pullRequests.getAll({ user: user, repo: repo }, (err, result) ->
        return reject(err) if err?
        resolve(result)
      )

  robot.respond /list-pr\s+(\w+)\/(\w+)$/i, (res) ->
    user = res.match[1]
    repo = res.match[2]

    listPullRequests user, repo
      .then (pulls) ->
        res.send pulls.map((pull) -> pull.title + '\n  ' + pull.url).join('\n')
      , (err) ->
        robot.logger.error err
        res.send 'list-pr error'
