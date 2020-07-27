class WashSerializer < ActiveModel::Serializer
  attributes :id, :wash_type, :created_at, :updated_at

  def wash_type
    object.wash_type.name
  end
end
