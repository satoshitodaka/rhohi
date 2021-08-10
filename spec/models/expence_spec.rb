require 'rails_helper'

RSpec.describe Expence, type: :model do
  describe Expence do
    # 有効なファクトリを持つこと
    it 'has a valid factory' do
      expect(FactoryBot.build(:expence)).to be_valid
    end

    before do
      company = Company.create(address: 'Tokyo')
      @user = User.create(
        name: 'サンプル 太朗',
        email: 'test@rhohi.com',
        password: 'password',
        company: company
      )
      @trip_statement = TripStatement.create(
        distination: 'Tokyo',
        purpose: 'Meeting',
        start_at: Time.zone.now,
        finish_at: Time.zone.now,
        work_done_at: Time.zone.now,
        user: @user
      )
    end

    # 日付、交通機関、出発地、到着地があれば有効であること
    it 'is valid with a date, transportation, bording, get_off' do
      expence = Expence.new(
        date: Time.zone.now,
        transportation: 'Train',
        bording: 'Tokyo',
        get_off: 'Ueno',
        trip_statement: @trip_statement
      )
      expence.valid?
      expect(expence).to be_valid
    end

    # 日付がなければ無効であること
    it 'is invalid without a date' do
      expence = FactoryBot.build(:expence, date: nil)
      expence.valid?
      expect(expence.errors[:date]).to include('を入力してください')
    end

    # 交通機関がなければ無効であること
    it 'is invalid without a transportation' do
      expence = FactoryBot.build(:expence, transportation: nil)
      expence.valid?
      expect(expence.errors[:transportation]).to include('を入力してください')
    end

    # 出発地がなければ無効であること
    it 'is invalid without a date' do
      expence = FactoryBot.build(:expence, bording: nil)
      expence.valid?
      expect(expence.errors[:bording]).to include('を入力してください')
    end

    # 到着地がなければ無効であること
    it 'is invalid without a date' do
      expence = FactoryBot.build(:expence, get_off: nil)
      expence.valid?
      expect(expence.errors[:get_off]).to include('を入力してください')
    end
  end
end
