describe 'Unit: Twittah service', ->
  $httpBackend = null
  myApiService = null
  apiURL = 'http://adaptive-test-api.herokuapp.com/tweets.json'

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
  beforeEach inject((apiService) ->
    myApiService = apiService
  )

  beforeEach inject(($injector) ->
    $httpBackend = $injector.get '$httpBackend'
    $httpBackend.when('GET', apiURL).respond(fakeResponses)
  )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'should have a twittah service', ->
    expect(myApiService).not.to.be.null
    expect(myApiService).not.to.be.undefined

  it 'should store data received from the API', ->
    tweets = []
    myApiService.getTweets().then (result) ->
      tweets = result.data
    $httpBackend.flush()
    expect(tweets).to.deep.equal fakeResponses
