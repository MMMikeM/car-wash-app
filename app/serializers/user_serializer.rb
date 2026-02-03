class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :contact_number, :roles, :authentication_token, :total_points, :washes, :loyalty_enabled

  has_many :vehicles

  def roles
    object.roles.map(&:name)
  end

  def washes
    object.washes.where(hidden: false)
  end
end
