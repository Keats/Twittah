describe 'Unit: Twittah service', ->
  $httpBackend = null
  twittahService = null
  apiURL =  'http://adaptive-test-api.herokuapp.com/tweets.json'

  fakeResponses = [
    created_at: "2012-09-27T16:13:31Z"
    followers: 9
    id: 6
    message: "Lemonade works for me"
    sentiment: 0.4
    updated_at: "2012-09-27T16:13:31Z"
    user_handle: "@lemonzest"
   ,
    created_at: "2012-09-27T16:13:31Z"
    followers: 15
    id: 7
    message: "Not for me"
    sentiment: -0.5
    updated_at: "2012-09-27T16:13:31Z"
    user_handle: "@actuallemon"
  ]

  beforeEach module('twittahServices')
  beforeEach inject(($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    twittahService = $injector.get 'twittahService'

    $httpBackend.when('GET', apiURL).respond(fakeResponses)
  )

  it 'should have a twittah service', ->
    expect(twittahService).not.to.be.null
