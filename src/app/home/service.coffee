twittah = angular.module 'twittahServices', []

# Service used to communicate with the REST API
apiService = ($http) ->
  api = {}
  apiURL = 'http://adaptive-test-api.herokuapp.com/tweets.json'
  tweets = []
  # Keeping track of tweets id to remove duplicates
  tweetsId = []

  # Returns the list of unique tweets we've already got from the server
  api.getCurrentTweets = ->
    tweets

  # Gets tweets from API, checks for duplicates and return the updated list of tweets
  api.getTweets = ->
    $http.get(apiURL).success (data) ->
      newTweets = []
      for tweet in data
        if tweet.id not in tweetsId
          newTweets.push tweet

      for newTweet in newTweets
        tweetsId.push newTweet.id

      tweets.push newTweets

  api

apiService.$inject = ['$http']

twittah.factory 'apiService', apiService
