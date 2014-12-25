require 'phisher/algos/search_engine_algo'
require 'phisher/data_sources/twitter_data_source'

class TwitterAlgo < SearchEngineAlgo

  def initialize(key, secret)
    super(TwitterDataSource.new(key: key, secret: secret))
  end

end


