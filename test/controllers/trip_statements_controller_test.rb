require 'test_helper'

class TripStatementsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @trip_statement = trip_statements(:one)
    @user = users(:satoshi)
  end

  test "should redirect index when not logged in" do
    get trip_statements_path
    assert_redirected_to new_user_session_url
  end

  test "should redirect new when not logged in" do
    get new_trip_statement_url
    assert_redirected_to new_user_session_url
  end

  test "should redirect edit when not logged in" do
    get edit_trip_statement_path(@trip_statement)
    assert_redirected_to new_user_session_url
  end

  test "should redirect show when not logged in" do
    get edit_trip_statement_url(@trip_statement)
    assert_redirected_to new_user_session_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'TripStatement.count' do
      post trip_statements_path, params: {
        trip_statement: { 
          distination: "tokyo",
          purpose: "meeting",
          applied: true,
          approved: false
        }
      }
    end
    assert_redirected_to new_user_session_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'TripStatement.count' do
      delete trip_statement_path(@trip_statement)
    end
    assert_redirected_to new_user_session_url
  end

  test "shoule redirect destroy for wrong trip_statement" do
    login_as(@user)
    @trip_statement = trip_statements(:two)
    assert_no_difference 'TripStatement.count' do
      delete trip_statement_path(@trip_statement)
    end
    assert_redirected_to root_url
  end
end
