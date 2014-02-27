twittah = angular.module 'twittahServices', []

# Service used to communicate with the REST API
apiService = ($http, $q) ->
  api = {}
  apiURL = 'http://adaptive-test-api.herokuapp.com/tweets.json'
  tweets = []

  # Returns the list of unique tweets we've already got from the server
  api.getCurrentTweets = ->
    tweets

  # Gets tweets from API, checks for duplicates and return the updated list of tweets
  api.getTweets = ->
    $http.get(apiURL).success (data) ->
      tweets.push data

  api

apiService.$inject = ['$http', '$q']

twittah.factory 'apiService', apiService
