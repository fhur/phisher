require 'spec_helper'

describe Site do

  let(:phishy_site) do
    site = Site.create url: "http://some.phishy-spamish-url.com"
    site.rating = 0.01
    return site
  end

  let(:safe_site) do
    site = Site.create url: "http://legiturl.com"
    site.rating = 0.99
    return site
  end

  describe '.phishy?' do

    it 'should show phishy if the site rating is high' do
      expect(phishy_site.phishy?).to be_truthy
    end

    it 'should not show phishy if the site rating is low' do
      expect(safe_site.phishy?).to be_falsy
    end

    it 'should return return phishy if the site is blacklisted' do
      safe_site.blacklisted = true
      expect(safe_site.phishy?).to be_truthy
    end
  end


end
