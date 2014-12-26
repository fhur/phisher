class WeightFunction

  # Returns a Hash that maps algos to the weight assigned
  # to such algo
  def weight(algos, url)
    raise "Unimplemented method: return the weight of the given algos #{algos}"
  end
end

# A weigh function that is implemented by passing a block
# to the constructor
class BlockWeightFunction < WeightFunction

  def initialize(&block)
    @block = block
  end

  def weight(algos, url)
    @block.call(algos, url)
  end
end

# A weighting function that assigns the same weight to every Algo
class UniformWeightFunction < WeightFunction

  # Returns:
  #   A Hash where the same weight is assigned uniformly to every algo
  #   (i.e. the weight is 1/num_algos)
  def weight(algos, url)
    weight = 1.to_f/algos.size # the same weight for each algo
    return Hash[algos.zip([weight]*algos.size)]
  end
end
