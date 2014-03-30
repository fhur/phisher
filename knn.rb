#
# Knn : K-Nearest-Neighbor
#
# the KNN algorithm is very simple
# Given a set of labeled training data, <x,f(x)> , a new input will
# becompared witheach x to determine the distance. After this the class
# of the k-closest distances will be chosen
#
#
# Usage Example:
#
# knn = Knn.new
#
# print "training Knn... "
# 10.times do |i|
#   klazz = 0
#   klazz = 1 if i >= 5
#   knn.train([i],klazz)
# end
#
# puts "[done]"
# knn.data_set.each_with_index {|klass,index| p "class #{index}: #{klass}"}
#
# puts "Classifying a few inputs"
# 20.times do |i|
#   test = i.to_f/2
#   print "#{test} =>"
#   puts knn.classify([test])
# end
#

class Knn

  def initialize(num_classes:2, k:5)
    @classes = Array.new(num_classes) {[]}
    @k = k
  end

  # class must be 0 or 1
  # data must be an array
  def train(data, klass)
    @classes[klass].push data
  end

  # for each training point, calculate the data and obtain the following set
  # [distance, class_index]
  def classify(input)
    distances = []
    @classes.each_with_index do |klass, index|
        distances += klass.map {|ex| [distance(ex, input), index]}
    end
    distances.sort!
    k_dists = distances.first(@k)
    classes = k_dists.map {|k_dist| k_dist[1]}
    return most_frequent(classes)
  end

  def distance(a,b)
    size = [a.size,b.size].min
    sum = 0
    size.times do |i|
      sum += (a[i] - b[i])**2
    end
    return Math.sqrt(sum)
  end

  def get_distances(klass, input)
    klass.map {|example| distance(input, example)}
  end

  # given a list of k_dists, returns the index of the most common
  # class
  # @param {Array} k_dists is an array of [distance, class_index] objects
  def most_frequent(classes)
    freqs = {}
    classes.each do |klass|
      freqs[klass] = 0 unless freqs[klass]
      freqs[klass] += 1
    end

    max_index = 0
    max_freq = 0
    freqs.each do |klass,freq|
      if max_freq < freq
        max_freq = freq
        max_index = klass
      end
    end
    return max_index
  end

  def data_set
    @classes
  end
end
