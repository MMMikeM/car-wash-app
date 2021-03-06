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

  validates :contact_number, uniqueness: true

  after_create :send_customer_sms
  after_create :add_customer_role

  def add_customer_role
    self.roles << Role.find_by_name('customer')
    self.save
  end

  def send_customer_sms
    return if Rails.env.development?

    message = ENV['NEW_CUSTOMER_MESSAGE'].gsub("<customer_name>", self.name)
    message = message.gsub("<password>", [self.name.to_s.tr(" ", "").first(6), self.contact_number].join("_"))
    ZoomConnectSmsJob.perform_async(self.contact_number.dup, message)
  end
end
