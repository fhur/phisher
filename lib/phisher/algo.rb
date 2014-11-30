class Algo

  attr_reader :weight

  # Creates a new instance of the algorithm with the given weight
  #
  # Arguments:
  #   {float} weight    the weight assigned to this algorithm.
  #
  def initialize(weight)
    @weight = weight
  end

  # Calculates the risk that a given url is phishy or safe.
  #
  # Risk is measured from 0 to 1 both inclusive where a risk
  # of 0 means that the url is completely safe and a risk of
  # 1 means that the url is completely phishy
  #
  # Arguments:
  #   {string} url    The url whose risk will be calculated
  #
  # Returns:
  #   A float in [0..1] indicating the risk of the given url
  #
  def risk(url)
    raise 'Subclasses must override risk(url) method'
  end

end
