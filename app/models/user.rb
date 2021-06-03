class User < ApplicationRecord
  rolify #:before_add => :before_add_method

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :company
  # belongs_to :department
  has_many :trip_statements, dependent: :nullify
  has_many :expences, through: :trip_statements # ユーザーから旅費情報を参照できる。
  has_many :approval, dependent: :nullify
  validates :name, presence: true
  validates :email, presence: true #このバリデーションがあってもなくても、テストが通ってしまう？
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, invite_for: 14.days

  
  after_create :assign_default_role
  after_create :assign_admin_role

  # たぶん無くてもOK
  # def before_add_method
  #   # Roleが追加されたときの処理があれば書く
  # end
  
  def assign_default_role
    self.add_role(:normal) if self.admin == false
  end

  def assign_admin_role
    self.add_role(:admin) if self.admin == true
  end


  private
    def admin?
      @user.admin == true
    end
      
end
