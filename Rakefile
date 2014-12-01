# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "phisher"
  gem.homepage = "http://github.com/fhur/phisher"
  gem.license = "MIT"
  gem.summary = %Q{Simple and extensible phishing detection gem}
  gem.description = %Q{Simple and extensible phishing detection gem}
  gem.email = "fernandohur@gmail.com"
  gem.authors = ["fhur"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

desc "Run all minitest tests"
task :test do
  Dir.glob("./test/**_spec.rb").each { |file| require file }
end

desc "Code coverage detail"
task :coverage do
  require 'simplecov'
  SimpleCov.start
  Rake::Task['test'].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "phisher #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
