require 'test_helper'

class ApproverActionTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:my_normal)
    @approver = users(:my_admin)
  end

  # ユーザーの出張申請を承認する。
  test "admin_user can approve other statement" do
    login_as(@approver)
    @other_users_statement = trip_statements(:my_applied_statement)
    get approvals_path
    assert_template 'approvals/index'
    get new_trip_statement_approval_path(@other_users_statement)
    assert_template 'approvals/new'
    assert_difference 'Approval.count', 1 do
      post trip_statement_approvals_path
    end
    @approval = Approval.last
    assert_equal true, @approval.approval
    assert_equal @user.id, @other_users_statement.user_id
    assert_equal true, @other_users_statement.reload.approved
    assert_equal @other_users_statement.id, @approval.trip_statement_id
  end

  # ユーザーの出張承認を否認する。
  test "admin_user can deny other statement" do
    login_as(@approver)
    @other_users_statement = trip_statements(:my_applied_statement)
    get approvals_path
    assert_template 'approvals/index'
    get new_trip_statement_approval_path(@other_users_statement)
    assert_template 'approvals/new'
    assert_difference 'Approval.count', 1 do
      post deny_approval_path, params: { approval:{comment: "test comment"}}
    end
    @approval = Approval.last
    assert_equal false, @approval.approval
    assert_equal "test comment", @approval.comment
    assert_equal false, @other_users_statement.reload.approved
  end

end
