require 'test_helper'

class ExpenceTest < ActiveSupport::TestCase
  
  def setup
    @trip_statement = trip_statements(:my_not_applied_statement)
    @expence = @trip_statement.expences.build(
      date: 2021-04-01, 
      transportation: "train",
      bording: "totsuka", 
      get_off: "tokyo",
      fare: 800
    )
  end

  test "should be valid" do
    assert @expence.valid?
  end

  test "date should be presence " do
    @expence.date = ""
    assert_not @expence.valid?
  end

  test "transportation should be presence " do
    @expence.transportation = ""
    assert_not @expence.valid?
  end

  test "bording should be presence " do
    @expence.bording = ""
    assert_not @expence.valid?
  end

  test "get_off should be presence " do
    @expence.get_off = ""
    assert_not @expence.valid?
  end

end
