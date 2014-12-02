require 'faraday'
require 'uri'
require 'json'
require 'phisher/data_source'

# Cached data source that searches a URL in DuckDuckGo (at api.duckduckgo.com)
# and fetches the number of related topics and the number of results
class DDGDataSource < DataSource

  URL = 'http://api.duckduckgo.com'

  def initialize
    @conn = Faraday.new(:url => URL)
    @cache = {} # initializes an empty cache. This maps url to [related_topics, results]
  end

  # Given a url this method will return the number of related topics for
  # that url and the number of results
  #
  #   [related_topics, results] = get(url)
  #
  # The most likely outcome for this method is that it will only recognize
  # 'big' websites.
  #
  # Arguments:
  #   {string} url the url to search for
  #
  # Returns:
  # An array of [related_topics, results]
  #
  def get(url)
    url = clean(url)
    return @cache[url] if @cache.include? url

    results = search(url)
    data = ['RelatedTopics', 'Results'].map do |key|
      results[key].size
    end
    return @cache[url] = data
  end

  private

  # Searches for a query in duckduckgo.
  # Returns a parsed JSON response for that query
  def search(query)
    response = @conn.get '/', { :q => query, :format => 'json' }
    if response.success?
      return JSON.parse(response.body)
    else
      raise "Failed to fetch query:#{query}"
    end
  end

  def clean(url)
    URI.parse(url).host
  end

end
