require 'spec_helper'

describe SitesController do

  let(:unsafe_site) do
    site = Site.create url: "http://falsebuk.org"
    site.blacklisted = true
    site.save!
    site
  end

  let(:safe_site) do
    site = Site.create url: "http://safeurl.org"
    site.whitelisted = true
    site.save!
    site
  end

  describe "GET 'sites/verify'" do
    it "returns 404 when url param is not found" do
      get 'verify', url: "ftp://some-odd-url"
      expect(response.status).to eq(404)
    end
    context "successful response" do
      it "returns 200 when the site is found" do
        get "verify", url: unsafe_site.url
        expect(response.status).to eq(200)
      end
      it "returns json containing the phishy param" do

      end
      it "has phishy=false when the queried url is safe" do

      end
      it "has phishy=true  when the queried url is unsafe" do

      end
    end

  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      get 'destroy'
      expect(response).to be_success
    end
  end

end
