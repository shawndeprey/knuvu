class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :avatar, :email, :created_at, :updated_at
end