require 'daybreak'
require 'phisher/data_source'

# An implementation of a DataSource backed by a cache that stored results
# in disk.
class CachedDataSource < DataSource

  attr_reader :cache

  def initialize(store_location)
    @cache = Daybreak::DB.new store_location
    at_exit { @cache.close }
  end

  # Returns:
  #   {Array} Returns a data representation of the given url as a vector (Array)
  #           This method is backed by a cache meaning that when DataSource#get is
  #           first called for a given url it might consume network resources.
  #           Afterwards the result is stored in a cache which means subsequent
  #           calls are very efficient.
  def get(url)
    cleaned_url = clean(url)
    if @cache.include? cleaned_url
      return @cache[cleaned_url]
    else
      fetched = fetch(cleaned_url)
      return @cache.set! cleaned_url, fetched
    end
  end

  # Subclasses must implement this method.
  # Given a url, this method should return the data that will be stored
  # in the cache. You must return an an array of primitive data types.
  #
  # Arguments:
  #   {string} url a url represented as a string
  #
  # Returns:
  #   {Array} an array of numbers
  def fetch(url)
    raise "Unimplemented method fetch(url)"
  end

  # Do some preprocessing on the url like removing protocol information so that
  # for example http and https urls map to the same cached reference.
  # by default this method does nothing.
  def clean(url)
    url
  end
end
