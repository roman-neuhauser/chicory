global.expect = (require 'chai').expect
chicory = require '../lib/chicory'

fstr = (fun) ->
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
