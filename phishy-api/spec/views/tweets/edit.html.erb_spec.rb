require 'spec_helper'

describe "tweets/edit" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :site_id => 1,
      :result_size => 1,
      :retweets => 1,
      :favs => 1
    ))
  end

  it "renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]", tweet_path(@tweet), "post" do
      assert_select "input#tweet_site_id[name=?]", "tweet[site_id]"
      assert_select "input#tweet_result_size[name=?]", "tweet[result_size]"
      assert_select "input#tweet_retweets[name=?]", "tweet[retweets]"
      assert_select "input#tweet_favs[name=?]", "tweet[favs]"
    end
  end
end
