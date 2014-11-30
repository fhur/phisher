#
# Knn : K-Nearest-Neighbor
#
# the KNN algorithm is very simple
# Given a set of labeled training data, <x,f(x)> , a new input will
# be compared with each x to determine the distance. After this the class
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

  attr_reader :training_set
  attr_reader :default_distance

  def initialize()
    @training_set = []
    @default_distance = lambda do |array1, array2|
      squares_sum = array1.zip(array2).map do |item|
        (item[0] - item[1])**2
      end
      Math.sqrt(squares_sum.reduce(:+))
    end
  end

  # Returns the class closest to the data point for a
  # given K
  #
  # Arguments:
  #   {Array} data an array
  #   {integer} k the number of classes to consider
  #   {block} distance an optional block in case you want
  #           to provide a custom distance function
  #
  # Returns:
  #   The class that the data array should belong to
  #
  def classify(data, k, &distance)

    if distance == nil
      distance = @default_distance
    end

    distances = @training_set.map do |training_point|
      [ distance.call(training_point.data, data), training_point.label ]
    end
    sorted_distances = distances.sort
    nearest_neightbors = sorted_distances.first(k)
    classes = nearest_neightbors.map { |neighbor| neighbor[1] }
    class_frequencies = get_class_frequencies(classes)
    most_frequent(class_frequencies)
  end

  # Classifies an array with the given label.
  #
  # Arguments:
  #   {Array} data the array that will be labeled
  #   {symbol} label an identifier for the label
  #
  # Returns:
  #   An instance of the training set
  def train(data, label)
    training_point = TrainingPoint.new data, label
    @training_set.push training_point
  end



  private

  # Given an array of where each element is a class label
  # this method returns the frequency of each label
  def get_class_frequencies(class_array)
    freqs = {}
    class_array.each do |clazz|
      freqs[clazz] = 0 unless freqs[clazz]
      freqs[clazz] += 1
    end
    return freqs
  end

  # Given a map of class => frequency(class)
  # This method returns the class with the highest
  # frequency.
  # If more than one class has the highest frequency
  # this method can return any of those classes.
  def most_frequent(class_frequencies)
    most_frequent_class = nil
    highest_frecuency = -1
    class_frequencies.each do |clazz, freq|
      if freq > highest_frecuency
        most_frequent_class = clazz
      end
    end
    return most_frequent_class
  end

end

class TrainingPoint < Struct.new(:data, :label); end
