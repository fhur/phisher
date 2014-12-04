require 'daybreak'
require 'phisher/data_source'

class CachedDataSource < DataSource

  attr_reader :cache

  def initialize(store_location)
    @cache = Daybreak::DB.new store_location
    at_exit { @cache.close }
  end

  def get(url)
    cleaned_url = clean(url)
    if @cache.include? cleaned_url
      return @cache[cleaned_url]
    else
      fetched = fetch(cleaned_url)
      return @cache.set! cleaned_url, fetched
    end
  end

  def fetch(url)
    raise "Unimplemented method fetch(url)"
  end

  # by default this method does nothing.
  def clean(url)
    url
  end
end
