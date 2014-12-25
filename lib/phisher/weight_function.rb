class WeightFunction

  def weight(algos, url)
    raise "Unimplemented method: return the weigth of the given algos #{algos}"
  end
end

# A weighting function that assigns the same weight to every Algo
class UniformWeightFunction < WeightFunction

  # Returns:
  #   A Hash where the same weight is assigned uniformly to every algo
  #   (i.e. the weight is 1/num_algos)
  def weigth(algos, url)
    weight = 1.to_f/algos.size # the same weight for each algo
    return Hash[algos.zip([weight]*algos.size)]
  end
end
