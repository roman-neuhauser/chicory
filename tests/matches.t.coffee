require './tools'

test (check, pass, fail, mode) ->

  describe "Matches with bare regexps (#{mode})", ->
    it 'is constructible', ->
      construct -> Matches /^foo$/

    it 'admits matching bare strings', ->
      pass -> (Matches /^foo$/) 'foo', check

    it 'admits matching string instances', ->
      pass -> (Matches /^foo$/) (new String 'foo'), check

    it 'rejects non-matching strings', ->
      fail -> (Matches /^foo$/) 'bar', check

    it 'rejects non-strings', ->
      fail -> (Matches /^foo$/) 42, check
      fail -> (Matches /^foo$/) foo: 'foo', check
      fail -> (Matches /^foo$/) ['foo'], check
      fail -> (Matches /^foo$/) undefined, check
      fail -> (Matches /^foo$/) true, check

  describe "Matches with RegExp instances (#{mode})", ->
    it 'is constructible', ->
      construct -> Matches (new RegExp /^foo$/), check

    it 'admits matching bare strings', ->
      pass -> (Matches new RegExp /^foo$/) 'foo', check

    it 'admits matching string instances', ->
      pass -> (Matches new RegExp /^foo$/) (new String 'foo'), check

    it 'rejects non-matching strings', ->
      fail -> (Matches new RegExp /^foo$/) 'bar', check

    it 'rejects non-strings', ->
      fail -> (Matches new RegExp /^foo$/) 42, check
      fail -> (Matches new RegExp /^foo$/) foo: 'foo', check
      fail -> (Matches new RegExp /^foo$/) ['foo'], check
      fail -> (Matches new RegExp /^foo$/) undefined, check
      fail -> (Matches new RegExp /^foo$/) true, check

