assert = require 'assert'
require '../lib/chicory'

pass = (expr) ->
  try
    expr()
  catch e
    console.log e
    console.log expr.toString()

fail = (expr) ->
  try
    expr()
  catch e
    return if e instanceof assert.AssertionError
    console.log e
  console.log "#{expr.toString()} succeeded"

pass ->  OfType Boolean
pass -> (OfType Boolean) true
pass -> (OfType Boolean) false
pass -> (OfType Boolean) Boolean 42
pass -> (OfType Boolean) new Boolean 42

fail -> (OfType Boolean) 42
fail -> (OfType Boolean) {}
fail -> (OfType Boolean) []
fail -> (OfType Boolean) ()->
fail -> (OfType Boolean) 'foo'

pass ->  OfType Number
pass -> (OfType Number) 0
pass -> (OfType Number) 0.1
pass -> (OfType Number) 0xff
pass -> (OfType Number) new Number 0xff

fail -> (OfType Number) 'foo'
fail -> (OfType Number) false
fail -> (OfType Number) {}

pass ->  OfType String
pass -> (OfType String) ''
pass -> (OfType String) 'foo'
pass -> (OfType String) new String 'foo'

fail -> (OfType String) false
fail -> (OfType String) 0
fail -> (OfType String) {}

pass ->  OfType RegExp
pass -> (OfType RegExp) //
pass -> (OfType RegExp) new RegExp '//'

fail -> (OfType RegExp) false
fail -> (OfType RegExp) 0
fail -> (OfType RegExp) {}
fail -> (OfType RegExp) ''

pass ->  OfType Array
pass -> (OfType Array) []
pass -> (OfType Array) [1..3]

fail -> (OfType Array) false
fail -> (OfType Array) 0
fail -> (OfType Array) {}
fail -> (OfType Array) ''

pass -> YesNo true
pass -> YesNo false
pass -> YesNo Boolean 42
pass -> YesNo new Boolean 42

fail -> YesNo 42
fail -> YesNo {}
fail -> YesNo []
fail -> YesNo ()->
fail -> YesNo 'foo'

pass ->  OneOf [42, 'foo', undefined]
pass -> (OneOf [42, 'foo', undefined]) 42
pass -> (OneOf [42, 'foo', undefined]) 'foo'
pass -> (OneOf [42, 'foo', undefined]) undefined

fail -> (OneOf [42, 'foo', undefined]) null
fail -> (OneOf [42, 'foo', null])      undefined
fail -> (OneOf [42, 'foo', undefined]) 40
fail -> (OneOf [42, 'foo', undefined]) 'FOO'
fail -> (OneOf [42, 'foo', undefined]) ''

pass -> (OneOf 42, 'foo', undefined) 42
pass -> (OneOf 42, 'foo', undefined) 'foo'
pass -> (OneOf 42, 'foo', undefined) undefined

fail -> (OneOf 42, 'foo') undefined

pass -> Integer 0
pass -> Integer 42
fail -> Integer 0.1
fail -> Integer 0.01
fail -> Integer 42.1
fail -> Integer 42.01

pass -> (Nonnegative Integer) 0
pass -> (Nonnegative Integer) 10

fail -> (Nonnegative Integer) 1.1
fail -> (Nonnegative Integer) -1
fail -> (Nonnegative Integer) -0.1

pass ->  OneOf YesNo, TrueFalse
pass -> (OneOf YesNo, TrueFalse) yes
pass -> (OneOf YesNo, TrueFalse) no
pass -> (OneOf YesNo, TrueFalse) 'true'
pass -> (OneOf YesNo, TrueFalse) 'false'

fail -> (OneOf YesNo, TrueFalse) 'yes'
fail -> (OneOf YesNo, TrueFalse) 'no'
fail -> (OneOf YesNo, TrueFalse) 0
fail -> (OneOf YesNo, TrueFalse) 1

pass ->  OneOf (OneOf YesNo, TrueFalse), Integer
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

