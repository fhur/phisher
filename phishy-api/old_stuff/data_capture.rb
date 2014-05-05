safe_sites = File.read('./data/safe_sites.txt').split("\n")
unsafe_sites = File.read('./data/unsafe_sites.txt').split("\n")

puts "Data Set consists of: "
puts "#{safe_sites.size} safe sites"
puts "#{unsafe_sites.size} unsafe sites"
puts ""
puts "Loading Tweet Data"
puts "For each tweeter search result, the following variables will be captured"
puts "  1. result size"
puts "  2. retweet count"
puts "  3. favorite count"
puts "  4. reply count"
puts ""

require "twitter"
client = Twitter::REST::Client.new do |config|
  config.consumer_key    = "du06D7CmAkv696YfuLmpnjnU1"
  config.consumer_secret = "QaHLeKgOvNdw97uz8TOmRGROr3ECYOCZlu3BQzJRvQlBRFyaY7"
end

def search(domain, client)
  return client.search(domain, :result_type => "recent").to_a
end

def get_tweet_data(domain, is_safe, client)
  tweets = search(domain, client)
  hash = {
    :is_safe => is_safe,
    :domain => domain,
    :result_size => tweets.size,
    :retweet_count => tweets.map {|tweet| tweet.retweet_count }.reduce(:+),
    :favorite_count => tweets.map {|tweet| tweet.favorite_count }.reduce(:+),
    :reply_count => tweets.map { |tweet| tweet.reply? }.map{|bool| bool ? 1: 0}.reduce(:+)
  }
  return hash
end

# initialize an empty array that will contain the array data
tweet_data = []

puts "Loading tweeter data for safe_sites"
safe_sites.each do |domain|
  print "loading #{domain}..."
  hash = get_tweet_data(domain, true, client)
  tweet_data.push hash
  puts " [done]"
end

puts "Loading tweeter data for unsafe_sites"
unsafe_sites.each do |domain|
  print "loading #{domain}..."
  hash = get_tweet_data(domain, false, client)
  tweet_data.push hash
  puts " [done]"
end

require 'json'
STORE_LOCATION = "./data/results.json"
puts
puts "Loading tweet info done."
puts "Storing data in '#{STORE_LOCATION}'"

File.open(STORE_LOCATION,'w') do |file|

  json = JSON(tweet_data)
  file.write json
end

puts "done"
