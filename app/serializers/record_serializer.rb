class RecordSerializer < ActiveModel::Serializer
  attributes :id, :artist_name, :title, :release_year, :condition
end
