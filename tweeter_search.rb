require "twitter"

class TweeterSearch

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = "du06D7CmAkv696YfuLmpnjnU1"
      config.consumer_secret = "QaHLeKgOvNdw97uz8TOmRGROr3ECYOCZlu3BQzJRvQlBRFyaY7"
    end
  end

  def search(domain)
    @client.search(domain, :result_type => "recent").to_a
  end

end
