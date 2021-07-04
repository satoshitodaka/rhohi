class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :company
  # belongs_to :department
  has_many :trip_statements, dependent: :nullify
  has_many :expences, through: :trip_statements # ユーザーから旅費情報を参照できる。
  has_many :approvals, dependent: :nullify
  validates :name, presence: true
  validates :email, presence: true #このバリデーションがあってもなくても、テストが通ってしまう？
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
      user.password = Rails.application.secrets.test_account_pass
      user.name = "ゲスト　太朗"
      user.company_id = 1
    end
  end

  # def own_user?
  #   @user = User.find(params[:id])
  # end

  private
    def admin?
      @user.admin == true
    end
      
end
