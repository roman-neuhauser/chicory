require './tools'

describe 'OfType String', ->
  it 'is constructible', ->
    construct -> OfType String

  it 'admits bare strings', ->
    pass -> (OfType String) ''
    pass -> (OfType String) 'foo'

  it 'admits String instances', ->
    pass -> (OfType String) new String 'foo'

  it 'rejects non-string values', ->
    fail -> (OfType String) false
    fail -> (OfType String) 0
    fail -> (OfType String) {}

