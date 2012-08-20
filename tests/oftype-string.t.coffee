require './tools'

test (check, pass, fail, mode) ->

  describe 'OfType String', ->

    it 'is constructible', ->
      construct -> OfType String

    it 'admits bare strings', ->
      pass -> (OfType String) '', check
      pass -> (OfType String) 'foo', check

    it 'admits String instances', ->
      pass -> (OfType String) (new String 'foo'), check

    it 'rejects non-string values', ->
      fail -> (OfType String) false, check
      fail -> (OfType String) 0, check
      fail -> (OfType String) {}, check

