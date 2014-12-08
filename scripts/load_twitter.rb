require 'phisher/data_sources/twitter_data_source'

twitter_key = ENV['TWITTER_KEY']
twitter_secret = ENV['TWITTER_SECRET']

[twitter_key, twitter_secret].each do |key|
  raise "key is nil " if key == nil
end

@ds = TwitterDataSource.new key: twitter_key, secret: twitter_secret

path = ARGV[0]

puts "Loading #{path}"

file = File.read(path)
urls = file.split "\n"

urls.each do |url|
  puts url
  begin
    @ds.get url
  rescue URI::InvalidURIError
  end
end


