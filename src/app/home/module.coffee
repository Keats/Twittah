
modules = [
  'ui.router.state',
]

home = angular.module 'Twittah.home', modules

homeConfig = ($stateProvider) ->
  $stateProvider.state "home",
    url: "/"
    controller: "HomeCtrl"
    templateUrl: "home/index.html"

    data:
      pageTitle: "Home"

homeConfig.$inject = ['$stateProvider']
home.config homeConfig

class HomeCtrl
  @$inject = ['$scope', 'apiService']

  constructor: (@scope, @apiService) ->
    @scope.tweets = []
    @scope.hasNewTweets = true
    # Prevents user from spamming the button
    @scope.queried = false

    @scope.getNewTweets = @getNewTweets
    @scope.getNewTweets()

    @scope.setOrderByPredicate = @setOrderByPredicate

  # Grabs new tweets from the API service and sets some data on the scope so
  # we can display everything correctly
  getNewTweets: =>
    # Don't do anything if we are already in the middle of a request
    if @scope.queried
      return

    @scope.queried = true
    @apiService.getTweets().then ((result) =>
      @scope.queried = false
      @scope.tweets = result.tweetsList
      @scope.hasNewTweets = result.numberNewTweets isnt 0
      @scope.errored = false
    ), (error) =>
      @scope.queried = false
      @scope.errored = true

  # Sets the predicate for the order of the tweets
  # If the new predicate is the same as the old, return the opposite ordering
  setOrderByPredicate: (predicate) =>
    if predicate is @scope.predicate
      @scope.predicate = "-#{ predicate }"
    else
      @scope.predicate = predicate


home.controller 'HomeCtrl', HomeCtrl
