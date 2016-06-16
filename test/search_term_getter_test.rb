require 'test_helper'
require 'search_term_getter'
require 'exiter'

class TestSearchTermGetter < Minitest::Test

  def test_that_it_gets_search_term
    ARGV.clear
    ARGV << "searchyterm"

    assert_equal  "searchyterm", SearchTermGetter.new(Exiter.new).get_search_term
  end

  def test_that_it_errors_out_if_search_term_is_not_entered
    ARGV.clear

    mock_exiter = Minitest::Mock.new
    mock_exiter.expect :exit_due_to_no_search_term, nil

    SearchTermGetter.new(mock_exiter).get_search_term

    mock_exiter.verify
  end
end