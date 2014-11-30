#
# Background script
#
#

api = new PhisherApi()

# called when an url is successfully verified agains the api
verify_success = (response)->
  console.log response

verify_error = (response)->
  if response.status == 404
    console.log response.responseJSON

# listen for tab changes
tabListener = (tabId, changeInfo, tab)->
  if changeInfo.status == "complete"
    console.log tab.url
    url = new URL(tab.url)
    api.verify url: url.hostname, success: verify_success, error: verify_error

# this file has changed
chrome.tabs.onUpdated.addListener(tabListener)
