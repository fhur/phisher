require 'phisher/algo'
require 'phisher/knn'

class SearchEngineAlgo < Algo

  #
  # Initializes the SearchEngineAlgo
  #
  # Arguments:
  #
  #   {integer} k default to 5, the K parameter to pass to the Knn algorithm
  #   {block} fetcher a block that takes as argument a url string
  #     without protocol information (e.g. dev.facebook.com/some-page)
  #     and returns an array with two elements. The first element
  #     is the number of search results returned by a search engine
  #     for the given url and the second parameter is the ranking of
  #     the given url in the returned search results. More formally
  #
  #       fetcher(url) => [num_results, ranking]
  #
  #     Where num_results is the total number of results for the given url
  #     and ranking is the ranking of that url in the top results (0 is top)
  #
  def initialize(weigth, data_source, k=2)
    super()
    @k = k
    @knn = Knn.new
    @data_source = data_source
  end

  def train(url, label)
    verify_label label
    # data is an Array of [num_results, ranking]
    data = @data_source.get(url)
    @knn.train data, label
  end

  def risk(url)
    data = @data_source.get(url)
    return @knn.classify(data, @k) == :safe ? 0 : 1
  end


  private

  def verify_label(label)
    unless [:phishy, :safe].include? label
      raise ArgumentError, "Unrecognized label #{label}"
    end
  end

end
