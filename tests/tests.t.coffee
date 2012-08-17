assert = require 'assert'
require '../lib/chicory'

pass = (expr) ->
  expr()

fail = (expr) ->
  try
    expr()
    throw new Error "#{expr.toString()} succeeded"
  catch e
    return if e instanceof assert.AssertionError
    throw e

describe 'OfType Boolean', ->
  it 'is constructible', ->
    pass -> OfType Boolean

  it 'admits bare booleans', ->
    pass -> (OfType Boolean) true
    pass -> (OfType Boolean) false
    pass -> (OfType Boolean) Boolean 42

  it 'admits Boolean instances', ->
    pass -> (OfType Boolean) new Boolean 42

  it 'rejects non-boolean values', ->
    fail -> (OfType Boolean) 'true'
    fail -> (OfType Boolean) 'false'
    fail -> (OfType Boolean) 42
    fail -> (OfType Boolean) {}
    fail -> (OfType Boolean) []
    fail -> (OfType Boolean) ()->
    fail -> (OfType Boolean) 'foo'

describe 'OfType Number', ->
  it 'is constructible', ->
    pass ->  OfType Number

  it 'admits bare numbers', ->
    pass -> (OfType Number) 0
    pass -> (OfType Number) 0.1
    pass -> (OfType Number) 0xff

  it 'admits Number instances', ->
    pass -> (OfType Number) new Number 0xff

  it 'rejects numeric strings', ->
    fail -> (OfType Number) '0'
    fail -> (OfType Number) '10'
    fail -> (OfType Number) '-10'

  it 'rejects non-number values', ->
    fail -> (OfType Number) 'foo'
    fail -> (OfType Number) false
    fail -> (OfType Number) {}

describe 'OfType String', ->
  it 'is constructible', ->
    pass ->  OfType String

  it 'admits bare strings', ->
    pass -> (OfType String) ''
    pass -> (OfType String) 'foo'

  it 'admits String instances', ->
    pass -> (OfType String) new String 'foo'

  it 'rejects non-string values', ->
    fail -> (OfType String) false
    fail -> (OfType String) 0
    fail -> (OfType String) {}

describe 'OfType RegExp', ->
  it 'is constructible', ->
    pass ->  OfType RegExp

  it 'admits bare regexps', ->
    pass -> (OfType RegExp) //

  it 'admits RegExp instances', ->
    pass -> (OfType RegExp) new RegExp '//'

  it 'rejects non-regexp values', ->
    fail -> (OfType RegExp) false
    fail -> (OfType RegExp) 0
    fail -> (OfType RegExp) {}
    fail -> (OfType RegExp) ''

describe 'OfType Array', ->
  it 'is constructible', ->
    pass ->  OfType Array

  it 'admits bare arrays', ->
    pass -> (OfType Array) []
    pass -> (OfType Array) [1..3]

  it 'admits Array instances', ->
    pass -> (OfType Array) new Array

  it 'rejects non-array values', ->
    fail -> (OfType Array) false
    fail -> (OfType Array) 0
    fail -> (OfType Array) {}
    fail -> (OfType Array) ''

describe 'YesNo', ->
  it 'admits bare booleans', ->
    pass -> YesNo true
    pass -> YesNo false

  it 'admits Boolean instances', ->
    pass -> YesNo Boolean 42
    pass -> YesNo new Boolean 42

  it 'rejects non-boolean values', ->
    fail -> YesNo 'false'
    fail -> YesNo 'true'
    fail -> YesNo 42
    fail -> YesNo {}
    fail -> YesNo []
    fail -> YesNo ()->
    fail -> YesNo 'foo'

describe 'OneOf with array', ->
  it 'is constructible', ->
    pass ->  OneOf [42, 'foo', undefined]

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
    pass ->  OneOf 42, 'foo', undefined

  it 'admits values given in arguments', ->
    pass -> (OneOf 42, 'foo', undefined) 42
    pass -> (OneOf 42, 'foo', undefined) 'foo'
    pass -> (OneOf 42, 'foo', undefined) undefined

  it 'rejects values not given in arguments', ->
    fail -> (OneOf 42, 'foo') undefined

describe 'Integer', ->
  it 'admits bare whole-number values', ->
    pass -> Integer -42
    pass -> Integer 0
    pass -> Integer 42

  it 'admits whole-number Number instances', ->
    pass -> Integer new Number -42
    pass -> Integer new Number 0
    pass -> Integer new Number 42

  it 'rejects real numbers', ->
    fail -> Integer 0.1
    fail -> Integer -0.01
    fail -> Integer 42.1
    fail -> Integer -42.01

    fail -> Integer new Number 0.1
    fail -> Integer new Number -0.01
    fail -> Integer new Number 42.1
    fail -> Integer new Number -42.01

describe 'Nonnegative Integer', ->
  it 'is constructible', ->
    pass ->  Nonnegative Integer

  it 'admits nonnegative integers', ->
    pass -> (Nonnegative Integer) 0
    pass -> (Nonnegative Integer) 10
    pass -> (Nonnegative Integer) new Number 0
    pass -> (Nonnegative Integer) new Number 10

  it 'rejects reals, negative numbers', ->
    fail -> (Nonnegative Integer) 1.1
    fail -> (Nonnegative Integer) -1
    fail -> (Nonnegative Integer) -0.1

describe 'OneOf nesting other matchers', ->
  it 'is constructible to first level', ->
    pass ->  OneOf YesNo, TrueFalse

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
    pass ->  OneOf (OneOf YesNo, TrueFalse), Integer

  it 'works on second level', ->
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) yes
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 'true'
    pass -> (OneOf (OneOf YesNo, TrueFalse), Integer) 42
    pass -> (OneOf (OneOf YesNo, TrueFalse), Nonnegative Integer) 42

o = (spec) ->
  return Match spec if spec instanceof RegExp
  return spec if typeof spec in ['function', 'object']
  assert 0, 'WTF!!!'

pass -> (Match /^foo$/) 'foo'
fail -> (Match /^foo$/) 'bar'

match = (spec, object) ->
  for p, m of spec
    if typeof m is 'function'
      m object[p]
    else
      match m, object[p]

pass ->
  x =o
    o: Optional YesNo
    n: OfType Number
    s: OfType String
    child:
      a: OfType Array
      b: OneOf 'hello', 'world'
  y =
    s: 'fubar'
    n: 42
    child:
      a: []
      b: 'hello'
    orphan: 'lost'
  match x, y

