class Site < ActiveRecord::Base

  def phishy?
    return true if blacklisted?
    return rating < 0.5
  end

  # Creates a new site with reasonable defaults
  def self.create(url: nil)
    site = Site.new
    site.blacklisted = false
    site.rating = 0.5
    site.url = url
    return site
  end

end

