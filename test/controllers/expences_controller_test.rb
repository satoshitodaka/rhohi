require 'test_helper'

class ExpencesControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  
  def setup
    @user = users(:satoshi)
    @trip_statement = trip_statements(:one)
    @expence = expences(:one_1)
  end

  test "should redirect new when not logged in" do
    get new_trip_statement_expence_path(@trip_statement)
    assert_redirected_to new_user_session_url
  end

  test "should redirect edit when not logged in" do
    get edit_expence_path(@expence)
    assert_redirected_to new_user_session_url
  end

  test "should redirect show when not logged in" do
    get expence_path(@expence)
    assert_redirected_to new_user_session_url
  end

  # 未ログインユーザーが旅費申請を作成する場合、Rootにリダイレクトするか？
  test "should redirect create not logged in" do
    assert_no_difference 'Expence.count' do
      post trip_statement_expences_path(@trip_statement), params: { expence:
        { date: '2021-05-01',
          transportation: "train",
          bording: "tokyo",
          get_off: "shimbashi",
          fare: 154
        }
      }
    end
    assert_redirected_to new_user_session_url
  end

  # 未ログインユーザーが旅費申請を削除する場合、Rootにリダイレクトするか？
  test "should redirect delete when not logged in" do
    assert_no_difference 'Expence.count' do
      delete expence_path(@expence)
    end
    assert_redirected_to new_user_session_url
  end

  # ユーザーが他人の旅費申請を削除する場合、Rootにリダイレクトするか？
  test "should redirect delete for wrong expence" do
    login_as(@user)
    assert_no_difference 'Expence.count' do
      @expence = expences(:two_1)
      delete expence_path(@expence)
    end
    assert_redirected_to root_url
  end

end
