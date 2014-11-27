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
end
