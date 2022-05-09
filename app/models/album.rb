# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  release_year :integer
#  artist_id    :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Album < ApplicationRecord
  include RecordUpdatable

  belongs_to :artist
  has_many :records

  validates :title, presence: true

  scope :count_by_year, -> { group(:release_year).count }

  def record_updatable_params(params)
    params.slice(:title, :release_year)
  end
end
