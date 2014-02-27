
modules = [
  'templates',

  'Twittah.home',
  'twittahServices',

  'ui.router.state'
]

appModule = angular.module 'Twittah', modules


appConfig = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'

appConfig.$inject = ['$stateProvider', '$urlRouterProvider']
appModule.config appConfig


appController = ($scope, $location) ->
  $scope.$on '$stateChangeSuccess',
  (event, toState, toParams, fromState, fromParams) ->
    if angular.isDefined(toState.data.pageTitle)
      $scope.pageTitle = toState.data.pageTitle + ' | Twittah'

appController.$inject = ['$scope', '$location']
appModule.controller 'AppCtrl', appController
