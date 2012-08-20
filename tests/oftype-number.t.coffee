require './tools'

describe 'OfType Number', ->
  it 'is constructible', ->
    construct -> OfType Number

  it 'admits bare numbers', ->
    pass -> (OfType Number) 0
    pass -> (OfType Number) 0.1
    pass -> (OfType Number) 0xff

  it 'admits Number instances', ->
    pass -> (OfType Number) new Number 0xff

  it 'rejects numeric strings', ->
    fail -> (OfType Number) '0'
    fail -> (OfType Number) '10'
    fail -> (OfType Number) '-10'

  it 'rejects non-number values', ->
    fail -> (OfType Number) 'foo'
    fail -> (OfType Number) false
    fail -> (OfType Number) {}

