global.expect = (require 'chai').expect
global.chicory = require '../lib/chicory'

fstr = (fun) ->
  fun.toString().replace \
    /^function \(\) \{[\S\s]+?return\s+([\S\s]+);[\S\s]+$/
  , '$1'

global.construct = (fun) ->
  (expect fun, (fstr fun)).to.not.throw()
  (expect fun(), (fstr fun)).to.be.a('function')

rpass = (fun) ->
  (expect fun, (fstr fun)).to.not.throw()

rfail = (fun) ->
  (expect fun, (fstr fun)).to.throw chicory.Mismatch

vpass = (fun) ->
  (expect fun(), (fstr fun)).to.be.true

vfail = (fun) ->
  (expect fun(), (fstr fun)).to.be.false

variants = [
  [chicory.raise, rpass, rfail, 'throwing']
, [chicory.value, vpass, vfail, 'using return values']
]

global.nothrow = rpass
global.throws = rfail
global.istrue = vpass
global.isfalse = vfail

global.test = (f) ->
  for tools in variants
    f tools...

