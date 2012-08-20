require './tools'

describe 'OfType Array', ->
  it 'is constructible', ->
    construct -> OfType Array

  it 'admits bare arrays', ->
    pass -> (OfType Array) []
    pass -> (OfType Array) [1..3]

  it 'admits Array instances', ->
    pass -> (OfType Array) new Array

  it 'rejects non-array values', ->
    fail -> (OfType Array) false
    fail -> (OfType Array) 0
    fail -> (OfType Array) {}
    fail -> (OfType Array) ''

