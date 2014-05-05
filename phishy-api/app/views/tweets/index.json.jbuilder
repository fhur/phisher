json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :site_id, :result_size, :retweets, :favs
  json.url tweet_url(tweet, format: :json)
end
