# hubot-list-pr

A Hubot script for listing Pull Requests.

## Installation

    $ npm install git://github.com/bouzuya/hubot-list-pr.git

or

    $ # TAG is the package version you need.
    $ npm install 'git://github.com/bouzuya/hubot-list-pr.git#TAG'

## Configuration

    $ export HUBOT_LIST_PR_TOKEN='...'
    $ export HUBOT_LIST_PR_DEFAULT_USERNAME='...'

## Commands

    bouzuya> hubot help list-pr
    hubot> hubot list-pr [<user>/]<repo> - list Pull Requests

    bouzuya> hubot list-pr hitoridokusho/hibot
    hubot> #1 pull request 1
               https://github.com/hitoridokusho/hibot/pull/1
           #2 pull request 2
               https://github.com/hitoridokusho/hibot/pull/2

    (HUBOT_LIST_PR_DEFAULT_USERNAME=hitoridokusho)
    bouzuya> hubot list-pr hibot
    hubot> #1 pull request 1
               https://github.com/hitoridokusho/hibot/pull/1
           #2 pull request 2
               https://github.com/hitoridokusho/hibot/pull/2

## License

MIT

## Badges

[![Build Status][travis-status]][travis]

[travis]: https://travis-ci.org/bouzuya/hubot-list-pr
[travis-status]: https://travis-ci.org/bouzuya/hubot-list-pr.svg?branch=master
