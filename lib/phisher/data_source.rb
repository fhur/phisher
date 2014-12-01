class DataSource

  # Returns an arbitrary object given an element.
  # The nature of the returned object varies by the type
  # of DataSource so for example a BingDataSource would
  # probably return bing search results information
  # for a given url.
  #
  # Arguments:
  #
  #   {string} url a url without protocol information
  #     (e.g.) foo.bar/som/page and without query
  #     parameters.
  #
  # Returns:
  # An object describing the url. Implementations decide
  # exactly what they will return.
  def get(url)
    raise 'Subclasses must implement get(url)'
  end
end
