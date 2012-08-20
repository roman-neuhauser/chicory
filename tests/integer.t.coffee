require './tools'

describe 'Integer', ->
  it 'admits bare whole-number values', ->
    pass -> Integer -42
    pass -> Integer 0
    pass -> Integer 42

  it 'admits whole-number Number instances', ->
    pass -> Integer new Number -42
    pass -> Integer new Number 0
    pass -> Integer new Number 42

  it 'rejects real numbers', ->
    fail -> Integer 0.1
    fail -> Integer -0.01
    fail -> Integer 42.1
    fail -> Integer -42.01

    fail -> Integer new Number 0.1
    fail -> Integer new Number -0.01
    fail -> Integer new Number 42.1
    fail -> Integer new Number -42.01

  it 'rejects numeric strings', ->
    fail -> Integer '0'
    fail -> Integer '4.2'
    fail -> Integer '10'
    fail -> Integer '-10'

describe 'Nonnegative Integer', ->
  it 'is constructible', ->
    construct -> Nonnegative Integer

  it 'admits nonnegative integers', ->
    pass -> (Nonnegative Integer) 0
    pass -> (Nonnegative Integer) 10
    pass -> (Nonnegative Integer) new Number 0
    pass -> (Nonnegative Integer) new Number 10

  it 'rejects reals, negative numbers', ->
    fail -> (Nonnegative Integer) 1.1
    fail -> (Nonnegative Integer) -1
    fail -> (Nonnegative Integer) -0.1

describe 'Integer, nonthrowing', ->
  id = (v) -> v
  it 'is false for non-numbers', ->
    (expect Integer 'hello', id).to.be.false
    (expect Integer ['hello'], id).to.be.false
  it 'is false for real numbers', ->
    (expect Integer 1.1, id).to.be.false
  it 'is true for whole numbers', ->
    (expect Integer 11, id).to.be.true

