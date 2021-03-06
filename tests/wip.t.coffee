require './tools'

assert = require 'assert'

o = (spec) ->
  return Matches spec if spec instanceof RegExp
  return spec if typeof spec in ['function', 'object']
  assert 0, 'WTF!!!'

match = (spec, object) ->
  for p, m of spec
    if typeof m is 'function'
      m object[p]
    else
      match m, object[p]
  true

exact = (spec, object) ->
  if not match spec, object
    false
  else
    for p of object
      if p not of spec
        return false
    true

istrue ->
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

