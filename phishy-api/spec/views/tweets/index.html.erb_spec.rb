require 'spec_helper'

describe "tweets/index" do
  before(:each) do
    assign(:tweets, [
      stub_model(Tweet,
        :site_id => 1,
        :result_size => 2,
        :retweets => 3,
        :favs => 4
      ),
      stub_model(Tweet,
        :site_id => 1,
        :result_size => 2,
        :retweets => 3,
        :favs => 4
      )
    ])
  end

  it "renders a list of tweets" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
