require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:satoshi)
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
end
