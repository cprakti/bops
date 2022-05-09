# == Schema Information
#
# Table name: records
#
#  id         :bigint           not null, primary key
#  condition  :integer          not null
#  notes      :text
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Record < ApplicationRecord
  include PgSearch::Model
  include RecordUpdatable

  belongs_to :album
  has_one :artist, through: :album

  validates :condition, presence: true
  validates :condition, numericality: {less_than_or_equal_to: 10, greater_than_or_equal_to: 0}

  pg_search_scope :search_by_title,
    associated_against: {album: :title},
    using: {
      tsearch: {
        prefix: true
      }
    }

  scope :where_title, ->(query) do
    search_by_title(query) if query.present?
  end

  def artist_name
    artist.name
  end

  def title
    album.title
  end

  def release_year
    album.release_year
  end

  def related_by_album
    album.records.pluck(:id) - [id]
  end

  def related_by_artist
    artist.records.pluck(:id) - [id]
  end

  def record_updatable_params(params)
    params.slice(:condition, :notes)
  end
end
