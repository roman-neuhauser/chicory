Desirables = ->

  # this lists some of the things i want to implement eventually

  IPv4Address         =o  (v) ->
    r = v.match /^(\d{1,3})\.(\d{1,3})\.(\d{1,3}).(\d{1,3})$/
    Fail unless r and r[4]
    for b in r[1..]
      Fail if b < 1 or b > 254
  Hostname            =o  /^[a-z]+[-a-z]*[a-z](:?\.[a-z]+[-a-z]*[a-z])*$/
  Host                =o  OneOf IP, Hostname
  Port                =o  Interval 1, 65536 + 1
  HostPort            =o  "#{Host}:#{Port}"
  Timestamp           =o  /^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ$/
  EmailAddress        =o  /^.+@.+$/
  URL                 =o  /^https?:\/\/.+$/
  Version             =o  /^\d+\.\d+\.\d+$/
  LocalPath           =o  /^(?:\/[^/]+)+/
  Basename            =o  /^[^/]+$/


assert = require 'assert'
util = require 'util'

class Mismatch
  name: "Mismatch"
  constructor: (@message) ->

exports.Mismatch = Mismatch

exports.raise = raise = (expr) ->
  unless expr
    throw new Mismatch expr
  else
    true

exports.value = id = (value) -> value

global.Matches = (re) ->
  (value, check = raise) ->
    ((OfType String) value, check) and (check re.test value)

global.OfType = (type) ->
  if type is Boolean
    (value, check = raise) ->
      check typeof value is 'boolean' or value instanceof Boolean
  else if type is Number
    (value, check = raise) ->
      check typeof value is 'number' or value instanceof Number
  else if type is String
    (value, check = raise) ->
      check typeof value is 'string' or value instanceof String
  else if type is Array
    (value, check = raise) ->
      check value instanceof Array
  else if type is RegExp
    (value, check = raise) ->
      check value instanceof RegExp
  else
    assert.fail "OfType #{type} not implemented"

global.YesNo = OfType Boolean

global.OneOf = (accepted...) ->
  if accepted.length is 1 and accepted[0] instanceof Array
    accepted = accepted[0]
  (value, check = raise) ->
    for match in accepted
      return true if value is match
      return true if typeof match is 'function' and match value, id
    check value in accepted

global.TrueFalse = OneOf 'true', 'false'

global.Integer = (value, check = raise) ->
  ((OfType Number) value, check) and (check (value - Math.round value) is 0)

global.Interval = (lo, hi) ->
  [lo, hi] = lo unless hi?
  (value, check = raise) ->
    ((OfType Number) value, check) and
    (check value >= lo) and
    (check value < hi)

global.Nonnegative = (Type) ->
  (value, check = raise) ->
    return (Type value, check) and (check value >= 0)

global.Optional = (Type) ->
  (value, check = raise) ->
    typeof value is 'undefined' or Type value, check
