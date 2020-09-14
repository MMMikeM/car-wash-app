class Vehicle < ApplicationRecord
  belongs_to :user
  validates :registration_number, uniqueness: { scope: :user_id }
  validates :registration_number, presence: true
end
