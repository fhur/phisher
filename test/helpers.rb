module TestHelpers

  # Asserts that the size of a list increments by the
  # given amount after the given block is executed.
  #
  # Example
  # list = []
  # assert_list_inc list, 2 do
  #   list += [1,2]
  # end
  #
  # Should pass because the list is incremented by 2.
  #
  # Arguments:
  #   {Array} init_list the initial array
  #   {integer} amount the amount that is expected to be
  #                    incremented. Defaults to 1.
  #   {block} an arbitrary block of code
  def assert_list_inc(init_list, amount=1, &block)
    dup_list = init_list.dup
    yield(block)
    init_list.size.must_equal(dup_list.size + amount)
  end

end
