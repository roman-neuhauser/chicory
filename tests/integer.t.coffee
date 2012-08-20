require './tools'

test (check, pass, fail, mode) ->

  describe "Integer (#{mode})", ->

    it 'admits bare whole-number values', ->
      pass -> Integer -42, check
      pass -> Integer 0, check
      pass -> Integer 42, check

    it 'admits whole-number Number instances', ->
      pass -> Integer (new Number -42), check
      pass -> Integer (new Number 0), check
      pass -> Integer (new Number 42), check

    it 'rejects real numbers', ->
      fail -> Integer 0.1, check
      fail -> Integer -0.01, check
      fail -> Integer 42.1, check
      fail -> Integer -42.01, check

      fail -> Integer (new Number 0.1), check
      fail -> Integer (new Number -0.01), check
      fail -> Integer (new Number 42.1), check
      fail -> Integer (new Number -42.01), check

    it 'rejects numeric strings', ->
      fail -> Integer '0', check
      fail -> Integer '4.2', check
      fail -> Integer '10', check
      fail -> Integer '-10', check

