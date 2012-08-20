global.expect = (require 'chai').expect
global.chicory = require '../lib/chicory'

global.fstr = (fun) ->
  fun.toString().replace \
    /^function \(\) \{[\S\s]+?return\s+([\S\s]+);[\S\s]+$/
  , '$1'

global.construct = (fun) ->
  (expect fun, (fstr fun)).to.not.throw()
  (expect fun(), (fstr fun)).to.be.a('function')

global.pass = (fun) ->
  (expect fun, (fstr fun)).to.not.throw()

global.fail = (fun) ->
  (expect fun, (fstr fun)).to.throw chicory.Mismatch

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

global.test = (f) ->
  for tools in variants
    f tools...

