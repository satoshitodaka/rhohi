require 'rails_helper'

RSpec.describe TripStatement, type: :model do
  describe TripStatement do
    before do
      company = Company.create(address: 'Tokyo')
      @user = User.create(
        name: 'サンプル 太朗',
        email: 'test@rhohi.com',
        password: 'password',
        company: company
      )
    end

    # # 有効なファクトリを持つこと
    # it 'has a valid factory' do
    #   expect(FactoryBot.build(:trip_statement)).to be_valid
    # end

    # 出張先、目的地、出発日時、帰着日時、作業終了日時、ユーザーがあれば有効な状態であること
    it 'is valid with a distination, purpose, start_at, finish_at, work_done_at, user' do
      trip_statement = TripStatement.new(
        distination: 'Tokyo',
        purpose: 'Meeting',
        start_at: Time.zone.now,
        finish_at: Time.zone.now,
        work_done_at: Time.zone.now,
        user: @user
      )
      trip_statement.valid?
      expect(trip_statement).to be_valid
    end

    # 出張先がなければ無効であること
    it 'is invald without a distination' do
      trip_statement = FactoryBot.build(:trip_statement, user: @user, distination: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:distination]).to include('を入力してください')
    end

    # 出張理由がなければ無効であること
    it 'is invald without a purpose' do
      trip_statement = FactoryBot.build(:trip_statement, user: @user, purpose: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:purpose]).to include('を入力してください')
    end

    # 出発日時がなければ無効であること
    it 'is invald without a start_at' do
      trip_statement = FactoryBot.build(:trip_statement, user: @user, start_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:start_at]).to include('を入力してください')
    end

    # 帰着日時がなければ無効であること
    it 'is invald without a finish_at' do
      trip_statement = FactoryBot.build(:trip_statement, user: @user, finish_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:finish_at]).to include('を入力してください')
    end

    # 作業終了日時がなければ無効であること
    it 'is invald without a work_done_at' do
      trip_statement = FactoryBot.build(:trip_statement, user: @user, work_done_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:work_done_at]).to include('を入力してください')
    end

    # `ユーザーがなければ無効であること
    it 'is invald without a user' do
      trip_statement = FactoryBot.build(:trip_statement, user: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:user]).to include('を入力してください')
    end
  end

  describe 'consistency about trip times' do
    # 出発日時は帰着日時より早い時間であること
    it 'start_atはfinish_atより早い'
    # 作業終了日時は帰着日時より早い時間であること
    it 'work_done_atはfinish_atより早い'
    # 出発日時は作業終了日時より早い時間であること
    it 'start_atはwork_done_atより早い'
  end
end
