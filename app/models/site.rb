class Site < ActiveRecord::Base

  def phishy?
    return rating < 0.5
  end

end

