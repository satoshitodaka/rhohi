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

    # 出張先、、目的地、出発日時、帰着日時、作業終了日時、ユーザーがあれば有効な状態であること
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
      trip_statement = TripStatement.new(distination: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:distination]).to include('を入力してください')
    end

    # 出張理由がなければ無効であること
    it 'is invald without a purpose' do
      trip_statement = TripStatement.new(purpose: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:purpose]).to include('を入力してください')
    end

    # 出発日時がなければ無効であること
    it 'is invald without a start_at' do
      trip_statement = TripStatement.new(start_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:start_at]).to include('を入力してください')
    end

    # 帰着日時がなければ無効であること
    it 'is invald without a finish_at' do
      trip_statement = TripStatement.new(finish_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:finish_at]).to include('を入力してください')
    end

    # 作業終了日時がなければ無効であること
    it 'is invald without a work_done_at' do
      trip_statement = TripStatement.new(work_done_at: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:work_done_at]).to include('を入力してください')
    end

    # `ユーザーがなければ無効であること
    it 'is invald without a user' do
      trip_statement = TripStatement.new(user: nil)
      trip_statement.valid?
      expect(trip_statement.errors[:user]).to include('を入力してください')
    end
  end
end
