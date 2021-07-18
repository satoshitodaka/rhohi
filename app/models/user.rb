class User < ApplicationRecord
  rolify
  
  # 関連付
  belongs_to :company
  # belongs_to :department
  has_many :trip_statements, dependent: :nullify
  has_many :expences, through: :trip_statements # ユーザーから旅費情報を参照できる。
  has_many :approvals, dependent: :nullify

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true #このバリデーションがあってもなくても、テストが通ってしまう？

  # devise
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, invite_for: 14.days
  
  def update_without_password(params, *options)
    # current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.guest
    find_or_create_by(email: "guest@rhohi.com") do |user|
      user.password = "password"
      user.name = "ゲスト 太朗"
      # user.company_id = 1
    end
  end

  def self.new_admin_guest
    User.find_or_create_by(email:"admin_guest@rhohi.com") do |admin_user|
      admin_user.password = "password"
      admin_user.name = "管理者 花子"
      admin_user.company_id = 1
      admin_user.admin = true
    end
  end

  # private
    # おそらく不使用
    # def admin?
    #   @user.admin == true
    # end
      
end
