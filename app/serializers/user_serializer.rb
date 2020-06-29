class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :contact_number

  has_many :vehicles
end
