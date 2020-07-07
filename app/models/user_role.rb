class UserRole < ApplicationRecord
  belongs_to :role
  belongs_to :user

  validates :role_id, presence: true
  validates :user_id, presence: true
  validates :role_id, uniqueness: { scope: %i(user_id) }
end
