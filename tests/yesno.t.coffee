require './tools'

test (check, pass, fail, mode) ->

  describe "YesNo (#{mode})", ->

    it 'admits bare booleans', ->
      pass -> YesNo true, check
      pass -> YesNo false, check

    it 'admits Boolean instances', ->
      pass -> YesNo (Boolean 42), check
      pass -> YesNo (new Boolean 42), check

    it 'rejects non-boolean values', ->
      fail -> YesNo 'false', check
      fail -> YesNo 'true', check
      fail -> YesNo 42, check
      fail -> YesNo {}, check
      fail -> YesNo [], check
      fail -> YesNo (->), check
      fail -> YesNo 'foo', check

