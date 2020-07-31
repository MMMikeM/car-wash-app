class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :contact_number, :roles, :authentication_token, :total_points

  has_many :vehicles
  has_many :washes

  def roles
    object.roles.map(&:name)
  end
end
