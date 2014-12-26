require 'phisher/url_list'
require 'phisher/weight_function'

class Phisher

  attr_reader :blacklist
  attr_reader :whitelist
  attr_reader :algos
  attr_reader :weight_function

  # Initializes a Phisher with a whitelist, blacklist and set of phishing detection algorithms
  #
  # Arguments:
  #   {Array} blacklist   an array of blacklisted urls as strings
  #   {Array} whitelist   an array of whitelisted urls as strings
  #   {Array} algos       an array of Algo subclasses
  #
  def initialize(blacklist: [], whitelist: [], algos: [], weight_function: UniformWeightFunction.new)
    @blacklist = Blacklist.new blacklist
    @whitelist = Whitelist.new whitelist
    @algos = algos
    @weight_function = weight_function
  end

  # Calculates the risk for a given url by testing the url against a blacklist, whitelist and a
  # set of phishing detection algorithms.
  #
  # This method follows the following rules:
  # 1. If the url is blacklisted then 1 is immediately returned
  # 2. If the url is whitelisted then 0 will be returned
  # 3. If neither (1.) nor (2.) occur then the url is tested agains the list of algorithms provided
  #    to the Phisher. The result is calculated as the weighted average of each algorithm's weight
  #    multiplied by the algorithm's risk score.
  #
  # Arguments:
  #   {String} url a url to test for safety
  #
  # Returns:
  #   A float between 0 and 1 indicating the risk associated with the url where 0 is the minimum
  #   amount of risk and 1 is the max risk.
  #
  def verify(url)

    # First check if the url is included in the blacklist, if so then return 1 (max risk)
    blacklisted = @blacklist.include? url
    return 1 if blacklisted

    # If the url is not blacklister, check if it is whitelisted and if so return 0 (min risk)
    whitelisted = @whitelist.include? url
    return 0 if whitelisted

    weights = @weight_function.weight(@algos, url)

    # if the url is neither black nor white listed then calcualte the weighted risk of the url
    # by each registered phishing detection algorithm
    weight_adjusted_risk = @algos.map do |algo|
      algo.risk(url)*weights[algo]
    end

    return weight_adjusted_risk.reduce(:+)
  end

end
