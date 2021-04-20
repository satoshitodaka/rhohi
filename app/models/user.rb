class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :company
  has_many :trip_statements, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true #このバリデーションがあってもなくても、テストが通ってしまう？
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
