require 'test_helper'

class CreateTripStatementTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:satoshi)
  end

  test 'create new trip_statement' do
    login_as(@user)
    get new_trip_statement_path
    assert_template 'trip_statements/new'
    # 無効な登録
    assert_no_difference 'TripStatement.count' do
      post trip_statements_path, params: {
        trip_statement: {
          distination: "",
          purpose: "",
          start_at: Time.zone.now,
          finish_at: Time.zone.now,
          work_done_at: Time.zone.now
        }
      }
    end
    assert_template 'trip_statements/new'
    # 有効な登録
    assert_difference 'TripStatement.count', 1 do
      post trip_statements_path, params: {
        trip_statement: {
          distination: "Nagano",
          purpose: "Meeting",
          start_at: Time.zone.now,
          finish_at: Time.zone.now,
          work_done_at: Time.zone.now
        }
      }
    end
    # assert_redirected_to trip_statement_url
    follow_redirect! # trip_statementのshowページに遷移する。
    assert_not flash.empty?
  end

  test "create new expence" do
    login_as(@user)
    @trip_statement = trip_statements(:one)
    get trip_statements_path
    assert_template 'trip_statements/index'
    get trip_statement_path(@trip_statement)
    assert_template 'trip_statements/show', "登録済みの出張情報のページに遷移するか"
    get new_trip_statement_expence_path(@trip_statement)
    assert_difference 'Expence.count', 1 do
      post trip_statement_expences_path(@trip_statement), params: {
        expence: {
          date: Time.zone.now,
          transportation: "山手線",
          bording: "上野",
          get_off: "東京",
          fare: 154,
          allowance: 0
        }
      }
    end
    assert_redirected_to trip_statement_path(@trip_statement)
    # assert_not flash.empty?
    # assert_select 'a[href=?]', edit_trip_statement_path(@trip_statement)
  end

  test "edit trip_statement & expence" do
    login_as(@user)
    @trip_statement = trip_statements(:one)
    @expence = expences(:one_1)
    get trip_statements_path
    assert_template 'trip_statements/index'
    get trip_statement_path(@trip_statement)
    # assertなんちゃら ここで表示の確認をする。
    get edit_expence_path(@expence)
    assert_template 'expences/edit'
    # assertなんちゃら ここで表示の確認をする。

  end

end