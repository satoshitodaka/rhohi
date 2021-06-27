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

    # result = if valid_password?(current_password)
    #   update_attributes(params, *options)
    # else
    #   self.assign_attributes(params, *options)
    #   self.valid?
    #   self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
    #   false
    # end

    update_attributes(params, *options)

    clean_up_passwords
    result
  end

  private
    def admin?
      @user.admin == true
    end
      
end
