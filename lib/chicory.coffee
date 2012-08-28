Desirables = ->

  # this lists some of the things i want to implement eventually

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

Mismatch = (msg, constr = this) ->
  Error.captureStackTrace this, constr
  @message = msg or 'Error'

util.inherits Mismatch, Error
Mismatch.prototype.name = 'Mismatch'

exports.Mismatch = Mismatch

exports.raise = raise = (expr) ->
  unless expr
    throw new Mismatch expr
  else
    true

exports.value = id = (value) -> value

exports.matchers = matchers = {}

matchers.IPv4Host = IPv4Host = (value, check = raise) ->

  re = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/
  ok = (b, low = 0) -> low <= b < 255

  return false unless (OfType String) value, check
  m = re.exec value
  return false unless check m
  return check ((ok m[1], 1) and (ok m[2]) and (ok m[3]) and (ok m[4], 1))

matchers.IPv4Net = IPv4Net = (value, check = raise) ->

  re = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/
  ok = (b, low = 0) -> low <= b < 255

  return false unless (OfType String) value, check
  m = re.exec value
  return false unless check m
  return check ((ok m[1], 1) and (ok m[2]) and (ok m[3]) and (ok m[4]))

matchers.Matches = Matches = (re) ->
  (value, check = raise) ->
    ((OfType String) value, check) and (check re.test value)

matchers.OfType = OfType = (type) ->
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

matchers.YesNo = YesNo = OfType Boolean

matchers.OneOf = OneOf = (accepted...) ->
  if accepted.length is 1 and accepted[0] instanceof Array
    accepted = accepted[0]
  (value, check = raise) ->
    for match in accepted
      return true if value is match
      return true if typeof match is 'function' and match value, id
    check value in accepted

matchers.TrueFalse = TrueFalse = OneOf 'true', 'false'

matchers.Integer = Integer = (value, check = raise) ->
  ((OfType Number) value, check) and (check (value - Math.round value) is 0)

matchers.Interval = Interval = (lo, hi) ->
  [lo, hi] = lo unless hi?
  (value, check = raise) ->
    ((OfType Number) value, check) and
    (check value >= lo) and
    (check value < hi)

matchers.Nonnegative = Nonnegative = (Type) ->
  (value, check = raise) ->
    return (Type value, check) and (check value >= 0)

matchers.Optional = Optional = (Type) ->
  (value, check = raise) ->
    typeof value is 'undefined' or Type value, check

exports[n] = m for n, m of matchers
