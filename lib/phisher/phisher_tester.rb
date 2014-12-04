class PhisherTester

  attr_reader :urls

  def initialize(urls: [], training_percent: 0.2)
    @urls = urls
    @training_percent = training_percent
  end

  # Trains a phisher instance and then tests the correctness
  # of the tested algorithm
  #
  # Arguments:
  #   {Phisher} phisher an instance of Phisher
  #   {block}   training_block(urls) where urls is an array of
  #             [url, label]. Label can be one of :safe or :phishy.
  #
  # Returns:
  #   A Hash of { phishy: [correct, total], safe: [correct, total] }
  def test(phisher, &training_block)

    shuffled = @urls.shuffle
    partitioned = partition(shuffled, @training_percent)

    # pass the training partition of urls to the
    # training bloc
    training_block.call(partitioned[:training])

    correct_classifications = {
      phishy: 0,
      safe: 0
    }

    total_classifications = {
      phishy: 0,
      safe: 0
    }

    partitioned[:testing].each do |url_item|
      url = url_item[0]
      exp_status = url_item[1]
      act_status = phisher.verify(url) > 0.5 ? :phishy : :safe
      correct_classifications[exp_status] += 1 if act_status
      total_classifications[exp_status] += 1
    end

    return {
      phishy: [
        correct_classifications[:phishy],
        total_classifications[:phishy]
      ],
      safe: [
        correct_classifications[:safe],
        total_classifications[:safe]
      ]
    }
  end

  # Partitions an array of urls in two.
  #
  # Arguments:
  #   {Array} urls an array of urls
  #   {float} training_percent a number between 0 and 1 indicating the percentage of
  #           the full array that should be allocated for training.
  #
  # Returns:
  #   A hash { training: training_partition, testing: testing_partition } where
  #   training_partition + testing_partition == urls
  def partition(urls, training_percent)
    training_size = urls.size*training_percent
    { training: urls.shift(training_size), testing: urls }
  end

end
