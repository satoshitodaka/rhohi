require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:satoshi)
    # @user = User.new(name: "ai", email: "aitodaka@rhohi.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be presence" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "associated trip_statements should be destroyed" do
    @user.save
    @user.trip_statements.create!(distination: "kagoshima", purpose: "recruit", applied: false, approved: false)
    assert_difference 'TripStatement.count', -1 do
      @user.destroy
    end
  end
end
