require 'phisher/knn'
require 'minitest/autorun'

describe Knn do

  before :each do
    @knn = Knn.new
  end

  describe 'default_distance' do

    before :each do
      @dist = @knn.default_distance
      @rand_list = lambda do |size|
        Array.new(size + 1) { rand }
      end
    end

    it 'should be greater than or equal to 0' do
      20.times do |i|
        d = @dist.(@rand_list.(i), @rand_list.(i))
        (d >= 0).must_equal true
      end
    end

    it 'should return 0 when two points are equal' do
      20.times do |i|
        point = @rand_list.(i)
        @dist.call(point, point).must_equal 0
      end
    end


    # symmetric: d(x,y) == d(y,x)
    it 'should be symmetric' do
      20.times do |i|
        point_a = @rand_list.(i)
        point_b = @rand_list.(i)
        @dist.call(point_a, point_b).must_equal(
          @dist.call(point_b, point_a)
        )
      end
    end

    # Triangle inequality: d(x,z) ≤ d(x,y) + d(y,z)
    it 'should satisfy the triangle inequality' do
      20.times do |i|
        x = @rand_list.(i)
        y = @rand_list.(i)
        z = @rand_list.(i)
        dist_sum = @dist.(x,y) + @dist.(y,z)
        (@dist.(x,z) <= dist_sum).must_equal true
      end
    end
  end

end
