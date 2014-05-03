class Site < ActiveRecord::Base

  def phishy?
    return true if blacklisted?
    return rating < 0.5
  end

end

