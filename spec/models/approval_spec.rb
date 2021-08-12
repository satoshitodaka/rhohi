require 'rails_helper'

RSpec.describe Approval, type: :model do
  # # 承認ステータス、ユーザーID、申請番号があれば有効であること
  # it 'is valid with a approval, user_id, trip_statement_id' do
  #   before do
  #     company = Company.create(address: 'Tokyo')
  #     @user = User.create(
  #       name: 'サンプル 太朗',
  #       email: 'test@rhohi.com',
  #       password: 'password',
  #       company: company
  #     )
  #   end
  # end

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:approval)).to be_valid
  end
  
end
