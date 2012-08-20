require './tools'

test (check, pass, fail, mode) ->

  describe "Nonnegative X (#{mode})", ->

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

