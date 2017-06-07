stream = require 'stream'

nextStream = ( current ) ->
  state = current._readableState
  switch state.pipesCount
    when 0 then undefined
    when 1 then state.pipes
    else
      state.pipes[ 0 ]

stream.Readable.prototype.last = ->
  last = this
  while next = nextStream last
    last = next
  last

stream.Readable.prototype.lpipe = ( dest, pipeOpts ) ->
  this.last( ).pipe dest, pipeOpts

module.exports = stream