class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vehicles, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  accepts_nested_attributes_for :vehicles
end
