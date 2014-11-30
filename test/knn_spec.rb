require 'phisher/knn'
require 'minitest/autorun'
require_relative './helpers'

describe Knn do
  include TestHelpers

  before :each do
    @knn = Knn.new
    @rand_list = lambda do |size|
      Array.new(size + 1) { rand }
    end
  end

  describe 'default_distance' do

    before :each do
      @dist = @knn.default_distance
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

  describe 'train' do

    it 'should increase the size of the training set' do
      1.upto(20) do |i|
        assert_list_inc @knn.training_set, i do
          i.times do
            @knn.train(@rand_list.(i), :label)
          end
        end
      end
    end
  end

  describe 'classify' do

    #
    # Initialize the following scenario
    #
    # 5 . . . C C
    # 4 . . . . C
    # 3 . A . . .
    # 2 A B B . .
    # 1 A A A . .
    # 0 1 2 3 4 5
    #
    # Dot means there is nothing at that location A,B,C
    # means that there is a point label with A,B,C at the
    # given coordinates
    #
    before :each do
      [[1,1], [2,1], [3,1], [1,2], [2,3]].each do |point|
        @knn.train(point, :a)
      end
      [[2,2], [3,2]].each do |point|
        @knn.train(point, :b)
      end
      [[5,4],[4,5],[5,5]].each do |point|
        @knn.train(point, :c)
      end
    end

    it 'should classify new points' do

      @knn.classify([2,4], 1).must_equal :a
      @knn.classify([6,6], 2).must_equal :c
      @knn.classify([7,7], 3).must_equal :c
      @knn.classify([7,7], 3).must_equal :c

      @knn.classify([2,2], 1).must_equal :b
      @knn.classify([2,2], 2).must_equal :a
      @knn.classify([2,2], 3).must_equal :a
    end
  end

end
