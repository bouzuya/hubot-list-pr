# Description
#   list-pr
#
# Dependencies:
#   "github": "^0.2.1",
#   "q": "^1.0.1"
#
# Configuration:
#   HUBOT_LIST_PR_DEFAULT_USERNAME
#   HUBOT_LIST_PR_TOKEN
#
# Commands:
#   hubot list-pr [<user>/]<repo> - list Pull Requests
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

  robot.respond /list-pr\s+(?:([\w\d][\w\d-]*)\/)?([\w\d-_]+)$/i, (res) ->
    user = res.match[1] ? process.env.HUBOT_LIST_PR_DEFAULT_USERNAME
    return unless user?
    repo = res.match[2]

    listPullRequests user, repo
      .then (pulls) ->
        if pulls.length > 0
          message = pulls
            .map (p) -> "\##{p.number} #{p.title}\n    #{p.html_url}"
            .join '\n'
          res.send message
      , (err) ->
        robot.logger.error err
        res.send 'list-pr error'
