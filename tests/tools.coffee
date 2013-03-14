global.expect = (require 'chai').expect
CUT = require '../lib/chicory'

global[n] = m for n, m of CUT.matchers

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
  (expect fun, (fstr fun)).to.throw CUT.Mismatch

vpass = (fun) ->
  (expect fun(), (fstr fun)).to.be.true

vfail = (fun) ->
  (expect fun(), (fstr fun)).to.be.false

variants = [
  [null, rpass, rfail, 'throwing']
, [CUT.value, vpass, vfail, 'using return values']
]

global.nothrow = rpass
global.throws = rfail
global.istrue = vpass
global.isfalse = vfail

global.test = (f) ->
  for tools in variants
    f tools...

