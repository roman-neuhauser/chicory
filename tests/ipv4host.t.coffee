require './tools'

test (check, pass, fail, mode) ->

  describe "IPv4Host (#{mode})", ->

    it 'admits IPv4 host addresses', ->
      pass -> IPv4Host '1.1.1.1', check
      pass -> IPv4Host '1.0.0.1', check
      pass -> IPv4Host '254.254.254.254', check

    it 'rejects non-string input', ->
      fail -> IPv4Host true, check
      fail -> IPv4Host false, check
      fail -> IPv4Host null, check
      fail -> IPv4Host {}, check
      fail -> IPv4Host [], check
      fail -> IPv4Host 127.1, check

    it 'rejects IPv4-like strings with wrong number of dots', ->
      fail -> IPv4Host '1', check
      fail -> IPv4Host '1.', check
      fail -> IPv4Host '.1', check
      fail -> IPv4Host '1.1', check
      fail -> IPv4Host '1.1.', check
      fail -> IPv4Host '.1.1', check
      fail -> IPv4Host '1.1.1', check

      fail -> IPv4Host '1.1.1.1.', check
      fail -> IPv4Host '.1.1.1.1', check

    it 'rejects IPv4 non-host addresses', ->
      fail -> IPv4Host '0.0.0.0', check
      fail -> IPv4Host '0.0.0.255', check
      fail -> IPv4Host '0.0.255.0', check
      fail -> IPv4Host '1.0.0.0', check
      fail -> IPv4Host '1.0.0.255', check
      fail -> IPv4Host '254.0.0.255', check
      fail -> IPv4Host '255.255.255.255', check

