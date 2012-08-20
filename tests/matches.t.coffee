require './tools'

describe 'Matches with bare regexps', ->
  it 'is constructible', ->
    construct -> Matches /^foo$/

  it 'admits matching bare strings', ->
    pass -> (Matches /^foo$/) 'foo'

  it 'admits matching string instances', ->
    pass -> (Matches /^foo$/) new String 'foo'

  it 'rejects non-matching strings', ->
    fail -> (Matches /^foo$/) 'bar'

  it 'rejects non-strings', ->
    fail -> (Matches /^foo$/) 42
    fail -> (Matches /^foo$/) foo: 'foo'
    fail -> (Matches /^foo$/) ['foo']
    fail -> (Matches /^foo$/) undefined
    fail -> (Matches /^foo$/) true

describe 'Matches with RegExp instances', ->
  it 'is constructible', ->
    construct -> Matches new RegExp /^foo$/

  it 'admits matching bare strings', ->
    pass -> (Matches new RegExp /^foo$/) 'foo'

  it 'admits matching string instances', ->
    pass -> (Matches new RegExp /^foo$/) new String 'foo'

  it 'rejects non-matching strings', ->
    fail -> (Matches new RegExp /^foo$/) 'bar'

  it 'rejects non-strings', ->
    fail -> (Matches new RegExp /^foo$/) 42
    fail -> (Matches new RegExp /^foo$/) foo: 'foo'
    fail -> (Matches new RegExp /^foo$/) ['foo']
    fail -> (Matches new RegExp /^foo$/) undefined
    fail -> (Matches new RegExp /^foo$/) true

