example = ->

  Decimal             =o  /^\d+\.\d+/
  Percent             =o  /^\d+%/
  Id                  =o  Nonnegative Integer
  Count               =o  Nonnegative Integer
  Seconds             =o  Nonnegative Integer
  IP                  =o  (v) ->
    r = v.match /^(\d{1,3})\.(\d{1,3})\.(\d{1,3}).(\d{1,3})$/
    Fail unless r and r[4]
    for b in r[1..]
      Fail if b < 1 or b > 254
  Hostname            =o  /^[a-z]+[-a-z]*[a-z](:?\.[a-z]+[-a-z]*[a-z])*$/
  Host                =o  OneOf IP, Hostname
  Port                =o  OneOf Interval 1, 65536 + 1
  HostPort            =o  "#{Host}:#{Port}"
  Envname             =o  OneOf 'development', 'production', 'testing'
  Hex32               =o  /^[a-f0-9]{32}$/i
  Hex40               =o  /^[a-f0-9]{40}$/i
  Timestamp           =o  /^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\dZ$/
  EmailAddress        =o  /^.+@.+$/
  String              =o  /.*/
  URL                 =o  /^https?:\/\/.+$/
  Version             =o  /^\d+\.\d+\.\d+$/
  MBytes              =o  Nonnegative Integer
  LocalPath           =o  /^(?:\/[^/]+)+/
  TrueFalse           =o  OneOf 'true', 'false'
  Username            =o  /^[-\w]+$/
  Groupname           =o  /^[-\w]+$/
  Basename            =o  /^[^/]+$/
  RunLevel            =o  OneOf [1..5]
  OnOff               =o  TypeOf Boolean
  YesNo               =o  TypeOf Boolean


massert = require 'assert'
assert = (args...) ->
  massert args...
  true
assert.fail = (args...) ->
  massert.fail args...
  true

id = (value) -> value

global.Match = (re) ->
  (value, check = assert) ->
    check re.test value

global.OfType = (type) ->
  if type is Boolean
    (value, check = assert) ->
      check typeof value is 'boolean' or value instanceof Boolean
  else if type is Number
    (value, check = assert) ->
      check typeof value is 'number' or value instanceof Number
  else if type is String
    (value, check = assert) ->
      check typeof value is 'string' or value instanceof String
  else if type is Array
    (value, check = assert) ->
      check value instanceof Array
  else if type is RegExp
    (value, check = assert) ->
      check value instanceof RegExp
  else
    assert.fail "OfType #{type} not implemented"

global.YesNo = OfType Boolean

global.OneOf = (accepted...) ->
  if accepted.length is 1 and accepted[0] instanceof Array
    accepted = accepted[0]
  (value, check = assert) ->
    for match in accepted
      return true if value is match
      return true if typeof match is 'function' and match value, id
    check value in accepted

global.TrueFalse = OneOf 'true', 'false'

global.Integer = (value, check = assert) ->
  check (value - Math.round value) is 0

global.Nonnegative = (Type) ->
  (value, check = assert) ->
    return (Type value, check) and (check value >= 0)

global.Optional = (Type) ->
  (value, check = assert) ->
    typeof value is 'undefined' or Type value, check
