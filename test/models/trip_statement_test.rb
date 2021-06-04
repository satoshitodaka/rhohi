require 'test_helper'

class TripStatementTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:my_admin)
    @trip_statement = @user.trip_statements.build(distination: "kamakura", purpose: "conference", user_id: @user.id)
  end

  test "should be valid" do # 存在性のテスト
    assert @trip_statement.valid?
  end

  test "user_id should be presence" do # 存在性のテスト(User_id)
    @trip_statement.user_id = ""
    assert_not @trip_statement.valid?
  end

  test "distination should be presence" do # 存在性のテスト(distination)
    @trip_statement.distination = ""
    assert_not @trip_statement.valid?
  end

  test "purpose should be presence" do # 存在性のテスト(purpose)
    @trip_statement.purpose = ""
    assert_not @trip_statement.valid?
  end

  test "associated expences should be destroyed" do # 出張情報を削除した場合、紐づく旅費情報は削除されるか？
    @trip_statement.save
    @trip_statement.expences.create!(date: '2021-04-15', transportation: "Train", bording: "Tokyo", get_off: "Shimbash")
    assert_difference 'Expence.count', -1 do
      @trip_statement.destroy
    end
  end
end
