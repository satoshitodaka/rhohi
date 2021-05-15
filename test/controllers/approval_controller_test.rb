require 'test_helper'

class ApprovalControllerTest < ActionDispatch::IntegrationTest

  def setup
    @approver_user = users(:megumi)
    @approved_statement = trip_statements(:approved)
  end

  # test "should get index" do
  #   get approval_index_url
  #   assert_response :success
  # end

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
  #   log_in_as(users(:megumi))

  # end

end
