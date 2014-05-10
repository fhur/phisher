'use strict'

# Declare app level module which depends on filters, and services
#App = angular.module('app', [
  #'ngCookies'
  #'ngResource'
  #'ngRoute'
  #'app.controllers'
  #'app.directives'
  #'app.filters'
  #'app.services'
  #'partials'
#])

#App.config([
  #'$routeProvider'
  #'$locationProvider'

#($routeProvider, $locationProvider, config) ->

  #$routeProvider

    #.when('/todo', {templateUrl: '/partials/todo.html'})
    #.when('/view1', {templateUrl: '/partials/partial1.html'})
    #.when('/view2', {templateUrl: '/partials/partial2.html'})

    ## Catch all
    #.otherwise({redirectTo: '/todo'})

  ## Without server side support html5 must be disabled.
  #$locationProvider.html5Mode(false)
#])

url = new URL(window.location.href).hostname

phishing_template = """

  <div class="alert">
    <h1> Phishing Alert !!!</h1>
    <p>This is a known phishing website! you should not use it!</p>
    <a> ignore </a> |
    <a> learn more </a>
  </div>
"""

verify_success = (response)->
  if response.phishy
    $('body').html(phishing_template)

verify_error = (response)->
  console.log response.responseJSON

api = new PhisherApi()
api.verify url: url, success: verify_success, error: verify_error
