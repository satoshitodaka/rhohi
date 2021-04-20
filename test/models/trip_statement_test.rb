require 'test_helper'

class TripStatementTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:megumi)
    @trip_statement = @user.trip_statements.build(distination: "kamakura", purpose: "conference", user_id: @user.id)
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

  

end
