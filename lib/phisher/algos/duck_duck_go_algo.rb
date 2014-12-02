
#
# The DuckDuckGoAlgo is a very strict subclass of
# SearchEngineAlgo that does domain only phishing
# i.e. given a url it will only take into account
# domain information for that url, search for it
# in DuckDuckGo and return results.
#
# This method has the advantage that it provides
# quick and easy phishing detection for most use
# cases but it will not be able to detect phishing
# on popular domains that allow for user generated
# content.
#
# Blogger in particular is known to host several phishy
# sites, but this Algo will not be able to detect it.
#
class DuckDuckGoAlgo < SearchEngineAlgo

  def initialize(weight)
    super(weight, DDGDataSource.new)
  end

end
