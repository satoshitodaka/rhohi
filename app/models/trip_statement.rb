class TripStatement < ApplicationRecord
  belongs_to :user
  has_many :expences, dependent: :destroy
  has_one :approval#,foreign_key: "trip_statement_id"
  validates :distination, presence: true
  validates :purpose, presence: true
  validates :user_id, presence: true

   

  # def add_approval
  #   self.update(approval: true, approval_at: Time.zone.now)
  # end

  # def add_denial
  #   self.update(approval: false, approval_at: Time.zone.now)
  # end


end
