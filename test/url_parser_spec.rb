require 'minitest/autorun'
require 'phisher/url_parser'

describe UrlParser do

  describe "parse" do

    it "should convert * wildcards to .* regex" do

      UrlParser.parse("*.google.com").must_equal(/\A.*\.google\.com\z/)
      UrlParser.parse("*.google.*").must_equal(/\A.*\.google\..*\z/)
      UrlParser.parse("*").must_equal(/\A.*\z/)
    end

    it "should match all urls matching wildcard" do
      UrlParser.parse("*.google.com").match("foo.google.com").wont_be_nil
      UrlParser.parse("google.*").match("google.com/page").wont_be_nil
      UrlParser.parse("*.google.com/*").match("foo.google.com/").wont_be_nil
      UrlParser.parse("google.com/*/foo").match("google.com/a/b/c/foo").wont_be_nil
    end

    it "should not match urls that don't match wildcard" do
      UrlParser.parse("google.com/*").match("foo.google.com/site").must_be_nil
    end


  end

end
