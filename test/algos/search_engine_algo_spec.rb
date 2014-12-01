require 'phisher/algos/search_engine_algo'
require 'minitest/autorun'

describe SearchEngineAlgo do

  before :each do
    # a mock fetcher that returns the size
    # and ranking as the url's size
    @se_algo = SearchEngineAlgo.new do |url|
      [url.size, url.size]
    end
  end

  describe 'train' do

    it 'adds a [num_results, ranking] data pair to the SearchEngineAlgo' do
      training_set = @se_algo.train('foo.com', :safe)
      training_set.last.data.must_equal [7,7]
    end

    it 'only allows labels :phishy and :safe' do
      [:unkown, :pheeshy,:phish, :save].each do |label|
        assert_raises ArgumentError do
          @se_algo.train('some-url.com', :unknown)
        end
      end
    end
  end

  describe 'risk' do

    # train the classifier to treat all urls with
    # size lte 15 as safe and size more than 15
    # as phishy
    before :each do
      1.upto(30) do |i|
        label = :phishy
        if i <= 15
          label = :safe
        end

        @se_algo.train('a' * i,label)
      end
    end

    it 'should classify urls properly' do
      ['foo.com', 'some.url', 'a.travel', 'pizza.org'].each do |url|
        @se_algo.risk(url).must_equal 0
      end

      ['long-weird-urls.com', 'some-more-long_urls.url',
        'very-long-a.travel', 'phishy-phishy-pizza.org'].each do |url|
        @se_algo.risk(url).must_equal 1
      end
    end

  end

end
