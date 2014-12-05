#
# Run this file as follows:
#
#   ruby -Ilib ./scripts/load_ddg.rb {path_to_urls}
#

require 'phisher/data_sources/ddg_data_source'

ds = DDGDataSource.new

urls = File.read(ARGV[0]).split("\n")

puts "#{urls.size} URLs read"

urls.each do |url|
  begin
    ds.get(url)
    print "."
  rescue
    puts
    puts "Error fetching #{url}"
    sleep 5
    retry
  end
end
