path = require 'path'

config = require path.resolve 'config'
console.log config

LindaClient = require('linda-socket.io').Client
socket = require('socket.io-client').connect(config.url)
linda = new LindaClient().connect(socket)

ts = linda.tuplespace("delta")

linda.io.on 'connect', ->
  console.log "connect!!"

  ts.watch {type: "door", cmd: "open", response: "success"}, (err, tuple) ->
    console.log tuple
    linda.tuplespace("masuilab").write ({type: "skype", cmd: "post", value: "deltaでドアが開きました"})
