class Vehicle < ApplicationRecord
  belongs_to :user
  validates :value, uniqueness: { scope: :user_id }
  validates :value, presence: true
end
