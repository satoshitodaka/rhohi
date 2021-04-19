class Department < ApplicationRecord
  belongs_to :company
  validates :department_name, presence: true
end
