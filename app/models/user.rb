class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # 関連付
  belongs_to :company
  # belongs_to :department
  has_many :trip_statements, dependent: :nullify
  has_many :expences, through: :trip_statements # ユーザーから旅費情報を参照できる。
  has_many :approval, dependent: :nullify

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true #このバリデーションがあってもなくても、テストが通ってしまう？

  # devise
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, invite_for: 14.days

  private
    def admin?
      @user.admin == true
    end
      
end
