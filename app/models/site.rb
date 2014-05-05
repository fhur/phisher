class Site < ActiveRecord::Base

  validates :url, presence: true, uniqueness: true
  validates :blacklisted, :inclusion => {:in => [true, false]}
  validates :whitelisted, :inclusion => {:in => [true, false]}
  validates :rating, presence: true

  has_many :tweets

  # returns true if the site is unsafe
  # A site is considered unsafe if it has a low rating or if it is blacklisted
  # A site is considered safe if it has a high rating or if it is whitelisted
  def phishy?
    if blacklisted? and whitelisted?
      raise Error, "site #{url} cannot be whitelisted and blacklisted at the same time"
    end

    return false if whitelisted?
    return true if blacklisted?
    return rating < 0.5
  end

  alias :phishy :phishy?

  # returns a hash containind the followin keys:
  # [:url, :blacklisted, :whitelisted, :rating, :phishy ]
  # @deprecated this is no longer needed, see views/sites/verify.json.jbuilder instead
  def to_verify_json
    fields = [:url, :blacklisted, :whitelisted, :rating, :phishy ]
    res = fields.map { |field| [field, self.send(field) ] }
    return Hash[res]
  end

  # Creates a new site with reasonable defaults
  def self.create(url: nil)
    site = Site.new
    site.blacklisted = false
    site.whitelisted = false
    site.rating = 0.5
    site.url = url
    return site
  end

  # creates a blacklisted site
  def self.create_blacklisted(url:nil)
    site = Site.new
    site.url = url
    site.blacklisted = true
    site.whitelisted = false
    site.rating = 0
    return site
  end

  def self.load_blacklist()
    phish_tank = PhishTank::Api.new ENV['phishtank_api']
    blacklisted_uris = phish_tank.blacklisted
    blacklisted_uris.each do |uri|
      site = Site.create_blacklisted url: uri
      site.save # this will attempt to save the site, it will fail if the url already exists in the db
    end
  end

end

