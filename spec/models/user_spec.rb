require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    # it 'has a valid factory' do
    #   expect(FactoryBot.build(:user)).to be_valid
    # end

    # 姓、名、メール、パスワード、会社名があれば有効な状態であること
    it 'is valid with a first name, last name, email, and password' do
      company = Company.create(address: 'Tokyo')
      user = User.new(
        name: 'サンプル 太朗',
        email: 'test@rhohi.com',
        password: 'password',
        company: company
      )
      expect(user).to be_valid
    end
    # 名がなければ無効な状態であること
    it 'is invalid without a name' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください') 
    end
    # メールアドレスがなければ無効な状態であること
    it 'is invalid without an email address' do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください') 
    end
    # 重複したメールアドレスなら無効な状態であること
    it 'is invalid with a duplicate email address' do
      company = Company.create(address: 'Tokyo')
      User.create(
        name: 'サンプル 太朗',
        email: 'test@rhohi.com',
        password: 'password',
        company: company
      )
      user = User.new(
        name: 'サンプル 太朗',
        email: 'test@rhohi.com',
        password: 'password',
        company: company
      )
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end
end
