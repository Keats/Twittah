
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

    @getNewTweets()

  getNewTweets: ->
    @apiService.getTweets().then (result) =>
      @scope.tweets = result.tweetsList
      @scope.hasNewTweets = result.numberNewTweets isnt 0


home.controller 'HomeCtrl', HomeCtrl
