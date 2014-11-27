require 'minitest/autorun'
require 'phisher/url_parser'

describe UrlParser do

  include UrlParser

  describe "parse" do

    it "should convert * wildcards to .* regex" do

      parse("*.google.com").must_equal(/\A.*\.google\.com\z/)
      parse("*.google.*").must_equal(/\A.*\.google\..*\z/)
      parse("*").must_equal(/\A.*\z/)
    end

    it "should match all urls matching wildcard" do
      parse("*.google.com").match("foo.google.com").wont_be_nil
      parse("google.*").match("google.com/page").wont_be_nil
      parse("*.google.com/*").match("foo.google.com/").wont_be_nil
      parse("google.com/*/foo").match("google.com/a/b/c/foo").wont_be_nil
    end

    it "should not match urls that don't match wildcard" do
      parse("google.com/*").match("foo.google.com/site").must_be_nil
    end

  end

end
