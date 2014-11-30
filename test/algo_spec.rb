require 'minitest/autorun'
require 'phisher/algo'

describe Algo do

  describe 'constructor' do
    it 'should set the weight of the Algo instance' do
      weight = 0.5
      algo = Algo.new weight
      algo.weight.must_equal weight
    end

  end

  describe 'risk(url)' do
    it 'should raise an error' do
      algo = Algo.new 1
      assert_raises RuntimeError do
        algo.risk('http://google.com')
      end
    end
  end
end
