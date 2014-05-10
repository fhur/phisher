class PhisherApi extends BaseApi

  verify:(args)->
    options =
      url: '/sites/verify'
      params:
        url: args.url
      success: args.success
      error: args.error
    get(options)

