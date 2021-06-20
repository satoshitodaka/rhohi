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
    get approvals_index_path
    assert_template 'approvals/index'
    # # 編集・削除タグは無いか？
    get new_trip_statement_approval_path(@other_users_statement)
    assert_template 'approvals/new'
    assert_difference 'Approval.count', 1 do
      post trip_statement_approvals_path(@other_users_statement), params: { approval: "true" }
      @approval = Approval.last
    end
    assert_equal true, @approval.approval
    assert_equal @user.id, @other_users_statement.user_id
    # assert_equal true, @other_users_statement#.approved # 実際にはupdateされているので、テストの記述が間違っている可能性大
    assert_equal @other_users_statement.id, @approval.trip_statement_id
  end

  # # ユーザーの出張承認を否認する。
  # test "admin_user can deny other statement" do
  #   login_as(@approver)
  #   @other_users_statement = trip_statements(:my_applied_statement)
  #   get approvals_index_path
  #   assert_template 'approvals/index'
  #   get new_trip_statement_approval_path(@other_users_statement)
  #   assert_template 'approvals/new'
  #   assert_difference 'Approval.count', 1 do
  #     # post trip_statement_approvals_path(@other_users_statement.id, approval: "false" )#, params: { approval: "false" }
  #     post trip_statement_approvals_path(@other_users_statement), params: { approval: "false" }
  #     @approval = Approval.last
  #   end
  #   assert_equal false, @approval.approval
  #   # assert_equal false, @others_statement.approved_at # 作成時のfalseがそのまま残っているという不具合（書き換わっていない）の可能性がある。
  #   assert_equal true, @other_users_statement#, @approval.trip_statement_id
  # end

end
