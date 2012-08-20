require './tools'

test (check, pass, fail, mode) ->

  describe "OneOf with array (#{mode})", ->

    it 'is constructible', ->
      construct -> OneOf [42, 'foo', undefined]

    it 'admits values contained in the array', ->
      pass -> (OneOf [42, 'foo', undefined]) 42, check
      pass -> (OneOf [42, 'foo', undefined]) 'foo', check
      pass -> (OneOf [42, 'foo', undefined]) undefined, check

    it 'rejects values not contained in the array', ->
      fail -> (OneOf [42, 'foo', undefined]) null, check
      fail -> (OneOf [42, 'foo', null])      undefined, check
      fail -> (OneOf [42, 'foo', undefined]) 40, check
      fail -> (OneOf [42, 'foo', undefined]) 'FOO', check
      fail -> (OneOf [42, 'foo', undefined]) '', check

  describe "OneOf with arguments (#{mode})", ->

    it 'is constructible', ->
      construct -> OneOf 42, 'foo', undefined

    it 'admits values given in arguments', ->
      pass -> (OneOf 42, 'foo', undefined) 42, check
      pass -> (OneOf 42, 'foo', undefined) 'foo', check
      pass -> (OneOf 42, 'foo', undefined) undefined, check

    it 'rejects values not given in arguments', ->
      fail -> (OneOf 42, 'foo') undefined, check

  describe "OneOf nesting other matchers (#{mode})", ->

    it 'is constructible to first level', ->
      construct -> OneOf YesNo, TrueFalse

    it 'works on first level', ->
      pass -> (OneOf YesNo, TrueFalse) yes, check
      pass -> (OneOf YesNo, TrueFalse) no, check
      pass -> (OneOf YesNo, TrueFalse) 'true', check
      pass -> (OneOf YesNo, TrueFalse) 'false', check

      fail -> (OneOf YesNo, TrueFalse) 'yes', check
      fail -> (OneOf YesNo, TrueFalse) 'no', check
      fail -> (OneOf YesNo, TrueFalse) 0, check
      fail -> (OneOf YesNo, TrueFalse) 1, check

    it 'is constructible to second level', ->
      construct -> OneOf (OneOf YesNo, TrueFalse), Integer

    it 'works on second level', ->
      pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) yes, check
      pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 'true', check
      pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 42, check
      pass -> (OneOf (OneOf YesNo, TrueFalse), Nonnegative Integer) 42, check

