through2 = require 'through2'

module.exports = through2.ctor objectMode : true, ( line, enc, cb ) ->
  fields = line.toString( 'utf8' ).split ' '
  this.push f for f in fields
  cb( )
