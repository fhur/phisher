require './ml/knn.rb'
require './data_processing/pre_processor'
require './data_capture/tweeter_search'

class Phisher

    attr_accessor :knn

    def initialize
        @knn = Knn.new(k:9)
        @pre_processor = PreProcessor.new
        @pre_processor.load
        @tweeter_search = TweeterSearch.new
    end

    def train
        @pre_processor.training_data.each_with_index do |data, label|
            data.each do |example|
                @knn.train example, label
            end
        end
    end

    def test
        num_correct = 0
        num_fails = 0
        @pre_processor.testing_data.each_with_index do |data, exp_label|
            data.each do |example|
                #puts "classifying #{example}"
                actual_label = @knn.classify(example)
                num_correct += 1 if actual_label == exp_label
                num_fails +=1 if actual_label != exp_label
            end
        end
        puts "Correct: #{num_correct}, Incorrect: #{num_fails} "
    end

    ###
    # given tweet data for a website returns 0 if the input is spam and 1 if not
    # Note: in order for the classifier to work properly the classifier must be trained.
    # To train simply call Phisher#train()
    ##
    def classify(domain)
        results = @tweeter_search.search(domain)
        hash = to_hash(results, domain)
        features = @pre_processor.get_features(hash)
        is_safe = @knn.classify(features) == 0
        return is_safe
    end

    def to_hash(tweets, domain)
        hash = {
            "domain_size" => domain.size,
            "result_size" => tweets.size,
            "retweet_count" => tweets.map {|tweet| tweet.retweet_count }.reduce(:+),
            "favorite_count" => tweets.map {|tweet| tweet.favorite_count }.reduce(:+),
            "reply_count" => tweets.map { |tweet| tweet.reply? }.map{|bool| bool ? 1: 0}.reduce(:+)
        }
        return hash
    end
end
