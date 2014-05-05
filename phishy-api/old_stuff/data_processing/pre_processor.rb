require 'json'

class PreProcessor

  attr_accessor :training_percent
  attr_accessor :training_data
  attr_accessor :testing_data

  def initialize(training_percent: 0.7, file: './data/tweet_data.2.json')
    @training_percent = training_percent
    @file = file
    @training_data = []
    @testing_data = []
  end

  # {
  #   "is_safe":true,
  #   "domain":"digitalocean.com",
  #   "domain_size":16,
  #   "result_size":369,
  #   "retweet_count":1580,
  #   "favorite_count":437,
  #   "reply_count":75
  # }
  def load()
    raw_data = JSON(File.read(@file))
    safe_sites = []
    unsafe_sites = []
    raw_data.each do |hash|
      is_safe = hash["is_safe"]
      features = get_features(hash)
      where = is_safe ? safe_sites : unsafe_sites
      where.push features
    end
    size = [safe_sites.size,unsafe_sites.size].min
    safe_sites = safe_sites.shuffle.first(size)
    unsafe_sites = unsafe_sites.shuffle.first(size)

    training_size = @training_percent*size
    testing_size = size - training_size

    @training_data.push safe_sites.first(training_size)
    @training_data.push unsafe_sites.first(training_size)
    @testing_data.push safe_sites.last(testing_size)
    @testing_data.push unsafe_sites.last(testing_size)
  end

  def get_features(hash)
    features = [
      hash["domain_size"] ||= 0,
      hash["result_size"] ||= 0,
      hash["retweet_count"]  ||= 0,
      hash["favorite_count"]  ||= 0,
      hash["reply_count"] ||= 0
    ]
    return features
  end

end
