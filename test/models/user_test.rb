require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:satoshi)
    @trip_statement = trip_statements(:one)
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

  test "associated trip_statements should be destroyed" do #ユーザーを削除しても申請情報は消えない。
    @user.save
    @user.trip_statements.create!(distination: "kagoshima", purpose: "recruit", applied: false, approved: false)
    assert_no_difference 'TripStatement.count' do
      @user.destroy
    end
  end

  test "associated approval should be destroyed" do #ユーザーを削除しても承認情報は消えない。
    @user.save
    @user.approval.create!(trip_statement_id: @trip_statement.id, approval: true)
    assert_no_difference 'Approval.count' do
      @user.destroy
    end
  end
end
