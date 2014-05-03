require 'spec_helper'

describe SitesController do

  let(:site1) do
    Site.create url: "http://falsebuk.org"
  end

  describe "GET 'show'" do
    it "returns 404 if id is not present" do
      get :show, :id => 2
      expect(response.status).to eq(404)
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      get 'update'
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      get 'destroy'
      expect(response).to be_success
    end
  end

end
