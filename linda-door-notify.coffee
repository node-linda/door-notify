path = require 'path'

config = require path.resolve 'config'
console.log config

LindaClient = require('linda-socket.io').Client
socket = require('socket.io-client').connect(config.url)
linda = new LindaClient().connect(socket)

tss = []
for name, yomi of config.spaces
  tss.push linda.tuplespace(name)

notify = (msg) ->
  for ts in tss
    ts.write {type: "say", value: msg}
    ts.write {type: "skype", cmd: "post", value: msg}
    ts.write {type: "slack", cmd: "post", value: msg}

linda.io.on 'connect', ->
  console.log "socket.io connect!!"

  for ts in tss
    do (ts) ->
      ts.watch {type: "door", cmd: "open", response: "success"}, (err, tuple) ->
        return if err
        console.log "#{ts.name}  - #{JSON.stringify tuple}"
        if tuple.data.who?
          msg = "#{config.spaces[ts.name]}で、#{tuple.data.who}がドアを開きました"
        else
          msg = "#{config.spaces[ts.name]}でドアが開きました"
        console.log msg
        notify msg

      ts.watch {type: "door", cmd: "close", response: "success"}, (err, tuple) ->
        return if err
        console.log "#{ts.name}  - #{JSON.stringify tuple}"
        if tuple.data.who?
          msg = "#{config.spaces[ts.name]}で、#{tuple.data.who}がドアを閉じました"
        else
          msg = "#{config.spaces[ts.name]}でドアが閉じました"
        console.log msg
        notify msg
