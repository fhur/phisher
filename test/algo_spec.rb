require 'minitest/autorun'
require 'phisher/algo'

describe Algo do

  describe 'risk(url)' do
    it 'should raise an error' do
      algo = Algo.new
      assert_raises RuntimeError do
        algo.risk('http://google.com')
      end
    end
  end
end
