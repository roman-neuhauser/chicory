require './tools'

test (check, pass, fail, mode) ->

  describe "Interval (#{mode})", ->

    it 'is constructible with a two-element number array', ->
      construct -> Interval [42, 69]
      construct -> Interval [(new Number 42), 69]
      construct -> Interval [42, (new Number 69)]
      construct -> Interval [(new Number 42), (new Number 69)]

    it 'is constructible with two number arguments', ->
      construct -> Interval 42, 69
      construct -> Interval (new Number 42), 69
      construct -> Interval 42, (new Number 69)
      construct -> Interval (new Number 42), (new Number 69)

    it 'rejects non-numbers', ->
      fail -> (Interval [42, 69]) '4', check
      fail -> (Interval [42, 69]) 'a', check
      fail -> (Interval [42, 69]) null, check
      fail -> (Interval [42, 69]) undefined, check
      fail -> (Interval [42, 69]) [50], check
      fail -> (Interval [42, 69]) {}, check

    it 'rejects numbers smaller than `lo`', ->
      fail -> (Interval [42, 69]) 41, check
      fail -> (Interval [42, 69]) 41.9, check
      fail -> (Interval [42, 69]) 0, check
      fail -> (Interval [42, 69]) -1, check

    it 'rejects numbers higher than `hi`', ->
      fail -> (Interval [42, 69]) 70, check
      fail -> (Interval [42, 69]) 69.1, check

    it 'rejects numbers equal to `hi`', ->
      fail -> (Interval [42, 69]) 69, check

    it 'accepts numbers equal to `lo`', ->
      pass -> (Interval [42, 69]) 42, check

    it 'accepts numbers greater than `lo`, smaller than `hi`', ->
      pass -> (Interval [42, 69]) 43, check
      pass -> (Interval [42, 69]) 68, check

