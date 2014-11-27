class Algo

  attr_reader :weight

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
    return 0
  end

end
