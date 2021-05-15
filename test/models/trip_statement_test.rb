require 'test_helper'

class TripStatementTest < ActiveSupport::TestCase
  
  def setup
    # @user = users(:megumi)
    @trip_statement = trip_statements(:one)#@user.trip_statements.build(distination: "kamakura", purpose: "conference", user_id: @user.id)
  end

  test "should be valid" do
    assert @trip_statement.valid?
  end

  test "user_id should be presence" do
    @trip_statement.user_id = ""
    assert_not @trip_statement.valid?
  end

  test "distination should be presence" do
    @trip_statement.distination = ""
    assert_not @trip_statement.valid?
  end

  test "purpose should be presence" do
    @trip_statement.purpose = ""
    assert_not @trip_statement.valid?
  end

  test "associated expences should be destroyed" do
    @trip_statement.save
    @trip_statement.expences.create!(date: '2021-04-15', transportation: "Train", bording: "Tokyo", get_off: "Shimbash")
    assert_difference 'Expence.count', -1 do
      @trip_statement.destroy
    end
  end
end
