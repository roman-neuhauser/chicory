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

rpass = (msg, fun) ->
  [msg, fun] = [null, msg] unless fun?
  (expect fun, (fstr fun)).to.not.throw()

rfail = (msg, fun) ->
  [msg, fun] = [null, msg] unless fun?
  (expect fun, (fstr fun)).to.throw (msg or CUT.Mismatch)

vpass = (msg, fun) ->
  [msg, fun] = [null, msg] unless fun?
  (expect fun(), (fstr fun)).to.be.true

vfail = (msg, fun) ->
  [msg, fun] = [null, msg] unless fun?
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

