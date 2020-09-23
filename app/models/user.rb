class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vehicles, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :washes
  accepts_nested_attributes_for :vehicles

  validates :contact_number, uniqueness: true, if: -> { hidden == false }

  after_create :send_customer_sms
  after_create :add_customer_role

  def add_customer_role
    self.roles << Role.find_by_name('customer')
    self.save
  end

  def send_customer_sms
    ZoomConnectSmsJob.perform_async(self.contact_number.dup, ENV['NEW_CUSTOMER_MESSAGE'].gsub("<customer_name>", self.name))
  end
end
