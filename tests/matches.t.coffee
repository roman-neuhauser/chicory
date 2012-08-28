require './tools'

test (check, pass, fail, mode) ->

  t = (msg, ctor) ->
    describe msg, ->
      it 'is constructible', ->
        construct -> Matches ctor /^foo$/

      it 'admits matching bare strings', ->
        pass -> (Matches ctor /^foo$/) 'foo', check

      it 'admits matching string instances', ->
        pass -> (Matches ctor /^foo$/) (new String 'foo'), check

      it 'rejects non-matching strings', ->
        fail -> (Matches ctor /^foo$/) 'bar', check

      it 'rejects non-strings', ->
        fail -> (Matches ctor /^foo$/) 42, check
        fail -> (Matches ctor /^foo$/) foo: 'foo', check
        fail -> (Matches ctor /^foo$/) ['foo'], check
        fail -> (Matches ctor /^foo$/) undefined, check
        fail -> (Matches ctor /^foo$/) true, check

  t "Matches with bare regexps (#{mode})", (v) -> v
  t "Matches with RegExp instances (#{mode})", (v) -> new RegExp v

