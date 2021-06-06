require 'test_helper'

class ApprovalControllerTest < ActionDispatch::IntegrationTest

  def setup
    @approver_user = users(:my_admin)
    @approved_statement = trip_statements(:approved)
    @other_company_user = users(:othre_normal)
    @other_company_user_trip_statement = trip_statements(:six)
  end

  test "should get index" do
    log_in_as(@approver_user)
    get approval_index_url
    assert_response :success
  end

  # test "should get show" do
  #   get approval_show_url
  #   assert_response :success
  # end

  # test "should get create" do
  #   get approval_create_url
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get approval_edit_url
  #   assert_response :success
  # end

  # test "should get update" do
  #   get approval_update_url
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get approval_destroy_url
  #   assert_response :success
  # end

  # test "approved trip_statement should not approved again" do
  #   log_in_as(users(:my_admin))

  # end

  # test "should redirect when approval other_company_user's trip_statement" do
  #   log_in_as(@approver_user)
  #   get new_trip_statement_approval_path(@other_company_user_trip_statement)
  #   redirect_to root_url

  # end

end
