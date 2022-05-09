class UpdatedRecordSerializer < ActiveModel::Serializer
  attributes :id, :artist_name, :title, :release_year, :condition, :related_records

  def related_records
    {
      by_album: object.related_by_album,
      by_artist: object.related_by_artist
    }
  end
end
