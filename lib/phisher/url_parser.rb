module UrlParser

  # Converts a url with wildcards to a regex
  #
  # Example:
  #
  #   "*.google.com" to /.*\.google\.com/
  def parse(url)
    /\A#{url.gsub('/','\/').gsub('.','\.').gsub('*','.*')}\z/
  end
end
