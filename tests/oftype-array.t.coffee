require './tools'

test (check, pass, fail, mode) ->

  describe "OfType Array (#{mode})", ->
    it 'is constructible', ->
      construct -> OfType Array

    it 'admits bare arrays', ->
      pass -> (OfType Array) [], check
      pass -> (OfType Array) [1..3], check

    it 'admits Array instances', ->
      pass -> (OfType Array) new Array, check

    it 'rejects non-array values', ->
      fail -> (OfType Array) false, check
      fail -> (OfType Array) 0, check
      fail -> (OfType Array) {}, check
      fail -> (OfType Array) '', check

