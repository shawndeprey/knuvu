class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :avatar_url, :email, :created_at, :updated_at
end