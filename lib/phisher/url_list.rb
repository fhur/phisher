require 'phisher/url_parser'

# Base class for a blacklist and whitelist
class UrlList
  include UrlParser

  attr_reader :list

  def initialize(list=[])
    @list = list.map do |url|
      parse(url)
    end
  end

  def include?(url)
    @list.each do |regex|
      return true if regex.match(url)
    end
    return false
  end

  def << (url)
    regex = parse(url)
    @list.push(regex)
  end

  def size
    @list.size
  end

end

class Blacklist < UrlList; end

class Whitelist < UrlList; end
