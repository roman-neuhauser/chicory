require './tools'

test (check, pass, fail, mode) ->

  describe "OfType Boolean (#{mode})", ->
    it 'is constructible', ->
      construct -> OfType Boolean

    it 'admits bare booleans', ->
      pass -> (OfType Boolean) true, check
      pass -> (OfType Boolean) false, check
      pass -> (OfType Boolean) (Boolean 42), check

    it 'admits Boolean instances', ->
      pass -> (OfType Boolean) (new Boolean 42), check

    it 'rejects non-boolean values', ->
      fail -> (OfType Boolean) 'true', check
      fail -> (OfType Boolean) 'false', check
      fail -> (OfType Boolean) 42, check
      fail -> (OfType Boolean) {}, check
      fail -> (OfType Boolean) [], check
      fail -> (OfType Boolean) (->), check
      fail -> (OfType Boolean) 'foo', check

