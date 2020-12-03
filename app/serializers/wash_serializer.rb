class WashSerializer < ActiveModel::Serializer
  attributes :id, :wash_type, :user, :created_at, :updated_at

  def wash_type
    object.wash_type.name
  end

  def user
    object.user
  end

  def vehicles
    object.user.vehicles
  end
end
