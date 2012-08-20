require './tools'

describe 'OneOf with array', ->
  it 'is constructible', ->
    construct -> OneOf [42, 'foo', undefined]

  it 'admits values contained in the array', ->
    pass -> (OneOf [42, 'foo', undefined]) 42
    pass -> (OneOf [42, 'foo', undefined]) 'foo'
    pass -> (OneOf [42, 'foo', undefined]) undefined

  it 'rejects values not contained in the array', ->
    fail -> (OneOf [42, 'foo', undefined]) null
    fail -> (OneOf [42, 'foo', null])      undefined
    fail -> (OneOf [42, 'foo', undefined]) 40
    fail -> (OneOf [42, 'foo', undefined]) 'FOO'
    fail -> (OneOf [42, 'foo', undefined]) ''

describe 'OneOf with arguments', ->
  it 'is constructible', ->
    construct -> OneOf 42, 'foo', undefined

  it 'admits values given in arguments', ->
    pass -> (OneOf 42, 'foo', undefined) 42
    pass -> (OneOf 42, 'foo', undefined) 'foo'
    pass -> (OneOf 42, 'foo', undefined) undefined

  it 'rejects values not given in arguments', ->
    fail -> (OneOf 42, 'foo') undefined

describe 'OneOf nesting other matchers', ->
  it 'is constructible to first level', ->
    construct -> OneOf YesNo, TrueFalse

  it 'works on first level', ->
    pass -> (OneOf YesNo, TrueFalse) yes
    pass -> (OneOf YesNo, TrueFalse) no
    pass -> (OneOf YesNo, TrueFalse) 'true'
    pass -> (OneOf YesNo, TrueFalse) 'false'

    fail -> (OneOf YesNo, TrueFalse) 'yes'
    fail -> (OneOf YesNo, TrueFalse) 'no'
    fail -> (OneOf YesNo, TrueFalse) 0
    fail -> (OneOf YesNo, TrueFalse) 1

  it 'is constructible to second level', ->
    construct -> OneOf (OneOf YesNo, TrueFalse), Integer

  it 'works on second level', ->
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) yes
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 'true'
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 42
    pass -> (OneOf (OneOf YesNo, TrueFalse), Nonnegative Integer) 42

