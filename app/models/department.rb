class Department < ApplicationRecord
  belongs_to :company
  # has_many :users
  validates :department_name, presence: true
end
