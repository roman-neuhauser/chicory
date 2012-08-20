require './tools'

describe 'OfType Boolean', ->
  it 'is constructible', ->
    construct -> OfType Boolean

  it 'admits bare booleans', ->
    pass -> (OfType Boolean) true
    pass -> (OfType Boolean) false
    pass -> (OfType Boolean) Boolean 42

  it 'admits Boolean instances', ->
    pass -> (OfType Boolean) new Boolean 42

  it 'rejects non-boolean values', ->
    fail -> (OfType Boolean) 'true'
    fail -> (OfType Boolean) 'false'
    fail -> (OfType Boolean) 42
    fail -> (OfType Boolean) {}
    fail -> (OfType Boolean) []
    fail -> (OfType Boolean) ()->
    fail -> (OfType Boolean) 'foo'

