require './tools'

test (check, pass, fail, mode) ->

  success = (msg, ctor) ->
    it msg, ->
      pass -> Integer (ctor -42), check
      pass -> Integer (ctor 0), check
      pass -> Integer (ctor 42), check

  failure = (msg, ctor) ->
    it msg, ->
      fail -> Integer (ctor 0.1), check
      fail -> Integer (ctor -0.01), check
      fail -> Integer (ctor 42.1), check
      fail -> Integer (ctor -42.01), check

  describe "Integer (#{mode})", ->

    success 'admits integer number primitives', (v) -> v
    success 'admits integer Number instances', (v) -> new Number v

    failure 'rejects real number primitives', (v) -> v
    failure 'rejects real Number instances', (v) -> new Number v

    it 'rejects numeric strings', ->
      fail -> Integer '0', check
      fail -> Integer '4.2', check
      fail -> Integer '10', check
      fail -> Integer '-10', check

