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

    it 'should not be phishy if whitelisted' do
      safe_site.whitelisted = true
      expect(safe_site.phishy?).to be_falsy
    end
  end

  it 'should raise or if a site is both whitelisted and blacklisted' do
    safe_site.whitelisted = true
    safe_site.blacklisted = true
    expect { safe_site.phishy? }.to raise_error
  end

  describe '.to_verify_json' do
    it 'includes the phishy key when calling' do
      hash = safe_site.to_verify_json
      expect(hash[:phishy]).to_not be_nil
    end
    it 'includes the phishy=> false mapping when site is safe' do
      hash = safe_site.to_verify_json
      expect(hash[:phishy]).to eq(false)
    end
    it 'includes the phishy=> true mapping when site is unsafe' do
      hash = phishy_site.to_verify_json
      expect(hash[:phishy]).to eq(true)
    end
  end

  describe 'required fields' do
    fields = [:url, :blacklisted, :whitelisted, :rating]
    fields.map! { |field| field.to_s << "=" }
    fields.each do |field|
      it "cannot have nil field #{field}}" do
        expect {
          tmp_site = Site.create url:"http://funky-pasta.com"
          tmp_site.send(field, nil)
          tmp_site.save!
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
