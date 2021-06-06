require 'test_helper'

class TripStatementsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @trip_statement = trip_statements(:my_not_applied_statement)
    @user = users(:my_normal)
    @admin_user = users(:my_admin)

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

  # 未ログインユーザーが申請を作成する場合、Rootにリダイレクトするか？
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

  # 未ログインユーザーが出張申請を削除する場合、Rootにリダイレクトするか？
  test "should redirect destroy when not logged in" do
    assert_no_difference 'TripStatement.count' do
      delete trip_statement_path(@trip_statement)
    end
    assert_redirected_to new_user_session_url
  end

  # ユーザーが他人の出張申請を削除する場合、Rootにリダイレクトするか？
  test "shoule redirect destroy for wrong trip_statement" do
    login_as(@user)
    @other_user_trip_statement = trip_statements(:my_not_applied_statement2)
    assert_no_difference 'TripStatement.count' do
      delete trip_statement_path(@other_user_trip_statement)
    end
    assert_redirected_to root_url
  end

  # ユーザーが他人の出張申請を編集(update)する場合、Rootにリダイレクトするか？
  test "should redirect update for wrong trip_statement" do
    login_as(@user)
    @other_user_trip_statement = trip_statements(:my_not_applied_statement2)
    patch trip_statement_path(@other_user_trip_statement), params: {
      trip_statement: { distination: "Osaka" } }
    assert_redirected_to root_url
  end

  # 一般ユーザーが他人の出張申請を閲覧する場合、Rootにリダイレクトするか？
  test "should redirect show for not_admin user" do
    login_as(@user)
    @other_user_trip_statement = trip_statements(:my_not_applied_statement2)
    get trip_statement_path(@other_user_trip_statement)
    assert_redirected_to root_url
  end
  
   # ユーザーが他人の出張申請を削除する場合、Rootにリダイレクトするか？
   test "should redirect destroy for wrong trip_statement" do
    login_as(@user)
    @other_user_trip_statement = trip_statements(:my_not_applied_statement2)
    assert_no_difference 'TripStatement.count' do
      delete trip_statement_path(@other_user_trip_statement)
    end
    assert_redirected_to root_url
  end
end
