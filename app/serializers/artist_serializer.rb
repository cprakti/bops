class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :releases_by_year
end
