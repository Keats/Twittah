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
  # along with the number of new tweets we got from the API
  api.getTweets = ->
    $http.get(apiURL).then (result) ->
      newTweets = []
      for tweet in result.data
        if tweet.id not in tweetsId
          newTweets.push tweet

      for newTweet in newTweets
        tweetsId.push newTweet.id

      tweets = tweets.concat newTweets
      result =
        tweetsList: tweets
        numberNewTweets: newTweets.length

      return result

  api

apiService.$inject = ['$http']

twittah.factory 'apiService', apiService
