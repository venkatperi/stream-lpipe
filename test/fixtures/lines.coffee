through2 = require 'through2'

module.exports = through2.ctor objectMode : true, ( chunk, enc, cb ) ->
  lines = chunk.toString( 'utf8' ).split /\r?\n/
  @push l for l in lines when l.length > 0
  cb( )
