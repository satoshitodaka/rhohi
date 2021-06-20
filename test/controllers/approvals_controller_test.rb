require 'test_helper'

class ApprovalsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @approver_user = users(:my_admin)
    @applied_statement = trip_statements(:my_applied_statement)
    @not_applied_statement = trip_statements(:my_not_applied_statement)
    @approved_statement = trip_statements(:my_approved_statement)
    @other_company_user = users(:other_normal)
    @other_company_user_trip_statement = trip_statements(:other_not_applied_statement)
  end

  test "should get index" do
    login_as(@approver_user)
    get approvals_index_url
    assert_response :success
  end

  test "should get new" do
    login_as(@approver_user)
    get new_trip_statement_approval_path(@applied_statement)
    assert_response :success
  end

  # 未提出の申請を承認するとリダイレクトする。
  test "should redirect when approval not_applied trip_statement" do
    login_as(@approver_user)
    assert_no_difference 'Approval.count' do
      post trip_statement_approvals_path(@not_applied_statement), params: { approval: "true" } 
    end
    assert_redirected_to approvals_index_url
    assert_not flash.empty?
  end

  # 承認済の申請を承認すると、リダイレクトする。
  test "should redirect when approval approved trip_statement" do
    login_as(@approver_user)
    assert_no_difference 'Approval.count' do
      post trip_statement_approvals_path(@approved_statement), params: { approval: "true" } 
    end
    assert_redirected_to approvals_index_url
    assert_not flash.empty?
  end

  # 他社のユーザーの申請を承認(create)すると、リダイレクトする。
  test "should redirect when create approval other company's trip_statement" do
    login_as(@approver_user)
    assert_no_difference 'Approval.count' do
      post trip_statement_approvals_path(@other_company_user_trip_statement), params: { approval: "true" }
    end
    assert_redirected_to approvals_index_url
    assert_not flash.empty?
  end

end
