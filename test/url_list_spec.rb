require 'minitest/autorun'
require 'phisher/url_list'

describe UrlList do

  describe 'constructor' do
    it 'should initialize the UrlList with the given wildcard urls ' do
      bl = UrlList.new ["a.com", "*.a.b", "foo.org/*"]
      bl.list.size.must_equal 3
    end
  end

  describe 'include?' do

    before :each do
      @bl = UrlList.new ['foo.org', 'fee.com', 'a.b.c/*', '*.bar.net']
    end

    it 'should return true when url is part of blacklist' do
      includes = ['foo.org','fee.com', 'a.b.c/', 'a.bar.net'].map do |url|
        @bl.include? url
      end
      result = includes.reduce(true) { |curr, acum| acum and curr }
      result.must_equal true
    end

    it 'should return false when url is part of blacklist' do
      includes = ['foo.orgo','a.fee.com', 'a.bee.c/', 'bar.netbiz'].map do |url|
        @bl.include? url
      end
      result = includes.reduce(false) { |curr, acum| acum or curr }
      result.must_equal false
    end
  end

  describe "<<" do

    it "should increase the size of a UrlList" do

      @list = UrlList.new
      urls = ['facebook.com','google.com','dropbox.com','github.com/*']
      urls.each do |url|
        @list << url
      end
      @list.size.must_equal urls.size

    end

  end

end
