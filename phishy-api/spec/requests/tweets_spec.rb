require 'spec_helper'

describe "Tweets" do
  describe "GET /tweets" do
    it "works! (now write some real specs)" do
      get tweets_path
      expect(response.status).to be(200)
    end
  end
end
