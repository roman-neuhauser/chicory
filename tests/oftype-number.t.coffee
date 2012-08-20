require './tools'

test (check, pass, fail, mode) ->

  describe "OfType Number (#{mode})", ->
    it 'is constructible', ->
      construct -> OfType Number

    it 'admits bare numbers', ->
      pass -> (OfType Number) 0, check
      pass -> (OfType Number) 0.1, check
      pass -> (OfType Number) 0xff, check

    it 'admits Number instances', ->
      pass -> (OfType Number) new Number 0xff, check

    it 'rejects numeric strings', ->
      fail -> (OfType Number) '0', check
      fail -> (OfType Number) '10', check
      fail -> (OfType Number) '-10', check

    it 'rejects non-number values', ->
      fail -> (OfType Number) 'foo', check
      fail -> (OfType Number) false, check
      fail -> (OfType Number) {}, check

