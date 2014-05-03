class Loader

  def initialize
    @safe_sites = File.read('data/safe_sites.txt').split("\n")
    @unsafe_sites = File.read('data/unsafe_sites.txt').split("\n")
  end

  def safe_sites
    @safe_sites
  end

  def unsafe_sites
    @unsafe_sites
  end
end
