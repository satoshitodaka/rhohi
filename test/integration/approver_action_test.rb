require 'test_helper'

class ApproverActionTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:hikaru)
    @approver = users(:satoshi)
  end

  # ユーザーの出張申請を承認する。
  test "admin_user can approve other statement" do
    login_as(@approver)
    @others_statement = trip_statements(:two)
    get approval_index_path
    assert_template 'approval/index'
    # 編集・削除タグは無いか？
    get new_trip_statement_approval_path(@others_statement)
    assert_template 'approval/new'
    # post trip_statement_approval_index_path(@approver), params: {
    #   approval: {
    #     trip_statement_id: @others_statement.id,
    #     approval: "true"
    #   }
    # }
    # assert_equal true, @others_statement.approved
  end
  # ユーザーの出張承認を否認する。


  # adminユーザーが他人の出張申請を編集する場合、リダイレクトするか？
  # test "should "
  # test "should redirect when admin_user edit other's trip_statement" do
  # end

  # adminユーザーが他人の出張申請を削除する場合、リダイレクトするか？
  # test "should redirect when admin_user delete other's trip_statement" do
  # end







end
