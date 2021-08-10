require 'rails_helper'

RSpec.describe Company, type: :model do
  describe Company do
    # 有効なファクトリを持つこと
    it 'has a valid factory' do
      expect(FactoryBot.build(:company)).to be_valid
    end

    # 住所と会社名があれば有効な状態であること
    it 'is valid with a name, address' do
      company = Company.new(
        address: 'Tokyo',
        name: 'rhohi company'
      )
      expect(company).to be_valid
    end

    # 住所がなければ無効であること
    it 'is invalid without a address' do
      company = FactoryBot.build(:company, address: nil)
      company.valid?
      expect(company.errors[:address]).to include('を入力してください')
    end
    # 会社名がなければ無効であること
    it 'is invalid without a name' do
      company = FactoryBot.build(:company, name: nil)
      company.valid?
      expect(company.errors[:name]).to include('を入力してください')
    end
  end
end
