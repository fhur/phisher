#
# Background script
#
#

tabListener = (tabId, changeInfo, tab)->
  if changeInfo.status == "complete"
    console.log tab.url

# this file has changed
chrome.tabs.onUpdated.addListener(tabListener)
