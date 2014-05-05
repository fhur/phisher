require "twitter"

###
# Wrapper on top of the twitter gem, provides searching of terms.
###
class TweeterSearch

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "du06D7CmAkv696YfuLmpnjnU1"
      config.consumer_secret = "QaHLeKgOvNdw97uz8TOmRGROr3ECYOCZlu3BQzJRvQlBRFyaY7"
    end
  end

  ###
  # returns an array of tweet results given a search term
  ###
  def search(domain)
    @client.search(domain, :result_type => "recent").to_a
  end

end
