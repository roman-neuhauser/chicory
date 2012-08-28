require './tools'

test (check, pass, fail, mode) ->

  describe "Nonnegative OfType Number (#{mode})", ->

    it 'is constructible', ->
      construct -> Nonnegative OfType Number

    it 'admits nonnegative numbers', ->
      pass -> (Nonnegative OfType Number) 0, check
      pass -> (Nonnegative OfType Number) 1.1, check
      pass -> (Nonnegative OfType Number) 10, check

      pass -> (Nonnegative OfType Number) (new Number 0), check
      pass -> (Nonnegative OfType Number) (new Number 1.1), check
      pass -> (Nonnegative OfType Number) (new Number 10), check

    it 'rejects negative numbers', ->
      fail -> (Nonnegative OfType Number) -1, check
      fail -> (Nonnegative OfType Number) -0.1, check

      fail -> (Nonnegative OfType Number) (new Number -1), check
      fail -> (Nonnegative OfType Number) (new Number -0.1), check

  describe "Nonnegative Integer (#{mode})", ->

    it 'is constructible', ->
      construct -> Nonnegative Integer

    it 'admits nonnegative numbers', ->
      pass -> (Nonnegative Integer) 0, check
      pass -> (Nonnegative Integer) 10, check

      pass -> (Nonnegative Integer) (new Number 0), check
      pass -> (Nonnegative Integer) (new Number 10), check

    it 'rejects real numbers', ->
      fail -> (Nonnegative Integer) 1.1, check
      fail -> (Nonnegative Integer) (new Number 1.1), check

    it 'rejects negative numbers', ->
      fail -> (Nonnegative Integer) -1, check
      fail -> (Nonnegative Integer) -0.1, check

      fail -> (Nonnegative Integer) (new Number -1), check
      fail -> (Nonnegative Integer) (new Number -0.1), check

