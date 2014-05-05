require "spec_helper"

describe TweetsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tweets").to route_to("tweets#index")
    end

    it "routes to #new" do
      expect(:get => "/tweets/new").to route_to("tweets#new")
    end

    it "routes to #show" do
      expect(:get => "/tweets/1").to route_to("tweets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tweets/1/edit").to route_to("tweets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tweets").to route_to("tweets#create")
    end

    it "routes to #update" do
      expect(:put => "/tweets/1").to route_to("tweets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tweets/1").to route_to("tweets#destroy", :id => "1")
    end

  end
end
