require 'phisher/data_source'
require 'twitter'
require 'daybreak'

class TwitterDataSource < DataSource

  def initialize(db_location='.twitter_data_source.db', key=nil, secret=nil)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = key
      config.consumer_secret = secret
    end

    @cache = Daybreak::DB.new(db_location)
    at_exit { @cache.close }
  end

  # Given a url returns an array with
  #
  # [
  #   user_follower_count,
  #   user_statuses_count
  #   retweet_count,
  #   favorite_count,
  #   possibly_sensitive
  # ]
  #
  # Where:
  #   - user_follower_count: the number of followers that
  #   the user who composed the tweet has.
  #   - user_statuses_count: the number of statuses
  #   composed by the user.
  #   - retweet_count: the number of times the tweet
  #   was retweeted
  #   - favorite_count: the number of times the tweet
  #   was followed
  #   - possibly_sensitive: 0 or 1 indicating if the
  #   tweet contains sensitive information or not
  #
  def get(url)
    host = clean(url)

    if @cache.include? host
      return @cache[host]
    else

      tweet_results = search(host)

      # for each tweet obtain 5 variables and store them
      # in the 'result_vector'.
      result_vector = tweet_results.map do |tweet|
        [
          tweet.user.followers_count,
          tweet.user.statuses_count,
          tweet.retweet_count,
          tweet.favorite_count,
          tweet.possibly_sensitive? ? 1 : 0
        ]
      end

      # Calculate the sum for each tweet over the 5 dimensions:
      # total_followers_count, total_statuses_count, total_retweet_count, ...
      vector_sums = result_vector.inject [0,0,0,0,0] do |memo, obj|
        memo.zip(obj).map { |vector| vector.reduce(:+) }
      end

      # Finally obtain the averages for each dimension:
      # avg_followers_count, avg_statuses_count, ...
      averages = vector_sums.map do |sum|
        sum.to_f/result_vector.size
      end

      # save and return the result.
      return @cache.set! host, averages
    end
  end

  private

  # return the host of a url. This method requires the url
  # to be properly configured with protocol information,
  # if not it will not return the correct values
  def clean(url)
    URI.parse(url).host
  end

  # (Blocking)
  # Searches for recent tweets matching the given query.
  # If the request fails because of TooManyRequests, it will
  # sleep the thread and reply when quota is available again.
  def search(query)
    begin
      @client.search(query, :result_type => 'recent').to_a
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end


end
