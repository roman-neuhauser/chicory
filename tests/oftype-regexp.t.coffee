require './tools'

describe 'OfType RegExp', ->
  it 'is constructible', ->
    construct -> OfType RegExp

  it 'admits bare regexps', ->
    pass -> (OfType RegExp) //

  it 'admits RegExp instances', ->
    pass -> (OfType RegExp) new RegExp '//'

  it 'rejects non-regexp values', ->
    fail -> (OfType RegExp) false
    fail -> (OfType RegExp) 0
    fail -> (OfType RegExp) {}
    fail -> (OfType RegExp) ''

