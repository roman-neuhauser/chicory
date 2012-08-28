require './tools'

test (check, pass, fail, mode) ->

  describe "IPv4Net (#{mode})", ->

    it 'admits IPv4 network addresses', ->
      pass -> IPv4Net '1.0.0.0', check
      pass -> IPv4Net '1.1.0.0', check
      pass -> IPv4Net '1.1.1.0', check

    it 'rejects non-string input', ->
      fail -> IPv4Net true, check
      fail -> IPv4Net false, check
      fail -> IPv4Net null, check
      fail -> IPv4Net {}, check
      fail -> IPv4Net [], check
      fail -> IPv4Net 127.1, check

    it 'rejects IPv4-like strings with wrong number of dots', ->
      fail -> IPv4Net '1', check
      fail -> IPv4Net '1.', check
      fail -> IPv4Net '.1', check
      fail -> IPv4Net '1.0', check
      fail -> IPv4Net '1.0.', check
      fail -> IPv4Net '.1.0', check
      fail -> IPv4Net '1.1.0', check

      fail -> IPv4Net '1.1.1.0.', check
      fail -> IPv4Net '.1.1.1.0', check

    it 'rejects IPv4 non-net addresses', ->
      fail -> IPv4Net '0.0.0.0', check
      fail -> IPv4Net '0.0.0.255', check
      fail -> IPv4Net '0.0.255.0', check
      fail -> IPv4Net '1.0.0.1', check
      fail -> IPv4Net '1.0.0.255', check
      fail -> IPv4Net '254.0.0.255', check
      fail -> IPv4Net '255.255.255.0', check
      fail -> IPv4Net '255.255.255.255', check

