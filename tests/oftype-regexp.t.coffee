require './tools'

test (check, pass, fail, mode) ->

  describe "OfType RegExp (#{mode})", ->
    it 'is constructible', ->
      construct -> OfType RegExp

    it 'admits bare regexps', ->
      pass -> (OfType RegExp) //, check

    it 'admits RegExp instances', ->
      pass -> (OfType RegExp) (new RegExp '//'), check

    it 'rejects non-regexp values', ->
      fail -> (OfType RegExp) false, check
      fail -> (OfType RegExp) 0, check
      fail -> (OfType RegExp) {}, check
      fail -> (OfType RegExp) '', check

