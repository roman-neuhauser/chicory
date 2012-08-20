require './tools'

describe 'YesNo', ->
  it 'admits bare booleans', ->
    pass -> YesNo true
    pass -> YesNo false

  it 'admits Boolean instances', ->
    pass -> YesNo Boolean 42
    pass -> YesNo new Boolean 42

  it 'rejects non-boolean values', ->
    fail -> YesNo 'false'
    fail -> YesNo 'true'
    fail -> YesNo 42
    fail -> YesNo {}
    fail -> YesNo []
    fail -> YesNo ()->
    fail -> YesNo 'foo'

