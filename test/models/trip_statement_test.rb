require 'test_helper'

class TripStatementTest < ActiveSupport::TestCase
  
  def setup
    @trip_statement = trip_statements(:first)
  end

  test "should be valid" do
    assert @trip_statement.valid?
  end

  test "distination should be presence" do
    @trip_statement.distination = ""
    assert_not @trip_statement.valid?
  end

  test "purpose should be presence" do
    @trip_statement.purpose = ""
    assert_not @trip_statement.valid?
  end

end
