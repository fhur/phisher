require 'minitest/autorun'
require 'phisher/data_sources/cached_data_source'

describe CachedDataSource do

  before :each do
    @ds = CachedDataSource.new './pkg/test.db'
    @ds.cache.clear
  end

  describe 'get' do
    it 'should return an element already stored in the cache' do
      @ds.cache['foo'] = [1,2,3,4]

      @ds.get('foo').must_equal [1,2,3,4]
    end

    it 'should call fetch when an element is not stored in the cache' do
      assert_raises RuntimeError do
        @ds.get('bar')
      end
    end
  end

end
