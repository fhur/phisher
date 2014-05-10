class BaseApi

  @BASE_URL = 'http://localhost:3000'

  constructor:()->

  # options
  #   url
  #   success
  #   error
  #   params
  get:(options)->
    $.ajax
      url: BaseApi.BASE_URL+options.url
      type: 'GET'
      success: options.success || ()->
      error: options.error || ()->
      data: options.params || {}
