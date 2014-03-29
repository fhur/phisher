require 'json'

json = File.read('./data/results.json')
data = JSON(json)

centroids = [
  {
    "result_size"=>395,
    "retweet_count"=>2314,
    "favorite_count"=>580,
    "reply_count"=>75
  },
  {
    "result_size"=>0,
    "retweet_count"=>0,
    "favorite_count"=>0,
    "reply_count"=>0
  }
]

# calculates the distance between a hash and a centroid
def distance(hash, centroid)
  result_size_dist = (hash["result_size"] - centroid["result_size"])**2
  retweet_count_dist = (hash["retweet_count"] - centroid["retweet_count"])**2
  favorite_count_dist = (hash["favorite_count"] - centroid["favorite_count"])**2
  reply_count_dist = (hash["reply_count"] - centroid["reply_count"])**2
  sum = [result_size_dist, retweet_count_dist, favorite_count_dist, reply_count_dist].reduce(:+)
  Math.sqrt(sum)
end

def assign_to_centroids(data, centroids)
  result = Array.new(centroids.size){[]}
  data.each do |hash|

    min_dist = distance(hash, centroids[0])
    min_index = 0
    centroids.each_with_index do |centroid, index|
      dist = distance(hash, centroid)
      if dist < min_dist
        min_dist = dist
        min_index = index
      end
    end

    result[min_index].push hash
  end
  return result
end

# given an array of examples, calculates the average value for a given key.
def calc_average(data_set, key)
  data_set.map { |hash| hash[key] }.reduce(:+).to_f/data_set.size
end

def calculate_centroids(centroid_data)
  centroids = []
  centroid_data.each do |data_set|
    hash = {
      "result_size" =>  calc_average(data_set, "result_size"),
      "retweet_count" => calc_average(data_set, "retweet_count"),
      "favorite_count" => calc_average(data_set, "favorite_count"),
      "reply_count" => calc_average(data_set, "reply_count")
    }
    centroids.push hash
  end
  return centroids
end

100.times do |i|

  centroid_data = assign_to_centroids(data, centroids)
  centroids = calculate_centroids(centroid_data)
  data = centroid_data.reduce(:+)
  puts "iteration: #{i}"
  puts centroids
end
