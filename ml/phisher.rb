require './ml/knn.rb'
require './data_processing/pre_processor'

class Phisher

    attr_accessor :knn

    def initialize
        @knn = Knn.new(k:10)
        @pre_processor = PreProcessor.new
        @pre_processor.load
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
                puts "classifying #{example}"
                actual_label = @knn.classify(example)
                num_correct += 1 if actual_label == exp_label
                num_fails +=1 if actual_label != exp_label
            end
        end
        puts "Correct: #{num_correct}, Incorrect: #{num_fails} "
    end
end

phisher = Phisher.new
phisher.train
phisher.test
