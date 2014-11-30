require './data_capture/tweeter_search.rb'
require './data_capture/loader.rb'
require 'json'
###
# Loads tweet data and stores it. This class handles rate limits silently
# so just run and let it go!
###
class TweetCollector

    def initialize()
        @loader = Loader.new
        @tweet_search = TweeterSearch.new

        @data_set = []
        @path = 'data/tweet_data.json'
    end

    def load_all
        safe_sites = @loader.safe_sites
        unsafe_sites = @loader.unsafe_sites

        safe_sites.each do |site|
            load(site, true)
        end
        unsafe_sites.each do |site|
            load(site, false)
        end
    end

    def load(domain, is_safe)
        begin
            print "loading data for #{domain}..."
            results = @tweet_search.search(domain)
            hash = to_hash(results, is_safe, domain)
            @data_set.push hash
            save()
            puts "[done]"
        rescue Twitter::Error::TooManyRequests => error
            reset_time = error.rate_limit.reset_in
            puts "There was an error: #{error} will retry in 5 secs"
            puts "Reset in #{reset_time}"
            sleep reset_time + 1
            retry
        end
    end

    def to_hash(tweets, is_safe, domain)
        hash = {
            :is_safe => is_safe,
            :domain => domain,
            :domain_size => domain.size,
            :result_size => tweets.size,
            :retweet_count => tweets.map {|tweet| tweet.retweet_count }.reduce(:+),
            :favorite_count => tweets.map {|tweet| tweet.favorite_count }.reduce(:+),
            :reply_count => tweets.map { |tweet| tweet.reply? }.map{|bool| bool ? 1: 0}.reduce(:+)
        }
        return hash
    end

    def save()
        puts "saving #{@data_set.size} to #{@path}"
        json = @data_set.to_json
        File.open @path,'w' do |file|
            file.write(json)
        end
    end

end

tweet_collector = TweetCollector.new
tweet_collector.load_all
