require 'minitest/autorun'
require 'phisher/phisher'
require 'phisher/algo'

class MockAlgo < Algo

  def initialize(risk)
    @risk = risk
  end

  def risk(url)
    @risk
  end
end

describe Phisher do

  before :each do
    @algos = [ MockAlgo.new(0.5), MockAlgo.new(0.1), MockAlgo.new(0.9)]
    wf = BlockWeightFunction.new do |algos|
      { @algos[0] => 0.2, @algos[1] => 0.5, @algos[2] => 0.3 }
    end
    @whitelist = ['*.foo.com','*.bar.bz','baz.nl/*','qux.org']
    @blacklist = ['lee.com','facebook.com','gmail.nl', 'gmail.nl/*']
    @phisher = Phisher.new whitelist: @whitelist, blacklist: @blacklist, algos: @algos, weight_function: wf
  end

  describe 'initialize' do
    it 'should initialize the blacklist' do
      phisher = Phisher.new whitelist: @whitelist
      phisher.whitelist.size.must_equal @whitelist.size
    end

    it 'should initialize the white list' do
      phisher = Phisher.new blacklist: @blacklist
      phisher.blacklist.size.must_equal @blacklist.size
    end

    it 'should initialize the algo list' do
      phisher = Phisher.new algos: @algos
      phisher.algos.must_equal @algos
    end
  end

  describe 'verify' do

    it 'should return 1 for a blacklisted url' do
      ['lee.com', 'facebook.com', 'gmail.nl', 'gmail.nl/some', 'gmail.nl/site'].each do |url|
        @phisher.verify(url).must_equal 1
      end
    end

    it 'should return 0 for a whitelisted url' do
      ['asd.foo.com', 'boo.bar.bz', 'baz.nl/', 'baz.nl/my-site', 'qux.org'].each do |url|
        @phisher.verify(url).must_equal 0
      end
    end

    it 'should return the weighted average of the algorithms result and their weight' do
      risk = @phisher.verify('someohtersite.com')
      risk.must_equal 0.5*0.2 + 0.1*0.5 + 0.9*0.3
    end

  end


end
