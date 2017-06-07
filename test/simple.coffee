stream = require '../lib/lpipe'
assert = require 'assert'
lines = require './fixtures/lines'
words = require './fixtures/words'
fs = require 'fs'
t2 = require 'through2'

fileName = "#{__dirname}/fixtures/lorem.txt"

count = {}

resetCounters = ->
  count.lines = 0
  count.words = 0

countLines = t2.ctor ( chunk, enc, cb ) ->
  count.lines++
  @push chunk
  cb( )

countWords = t2.ctor ( chunk, enc, cb ) ->
  count.words++
  @push chunk
  cb( )

describe 'split lines', ->

  it 'normal pipe', ( done ) ->
    resetCounters( )
    fs.createReadStream fileName
      .pipe lines( )
      .pipe countLines( )
      .pipe words( )
      .pipe countWords( )
      .on 'finish', ->
        assert count.lines is 5
        assert count.words is 431
        done( )

  it 'lpipe', ( done ) ->
    resetCounters( )
    s = fs.createReadStream fileName
    s.lpipe p for p in [ lines( ), countLines( ), words( ), countWords( ) ]

    s.last( ).on 'finish', ->
      assert count.lines is 5
      assert count.words is 431
      done( )

