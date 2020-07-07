class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  before_create :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
