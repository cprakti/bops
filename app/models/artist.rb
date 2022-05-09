# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  include RecordUpdatable

  has_many :albums
  has_many :records, through: :albums

  validates :name, presence: true

  def releases_by_year
    albums.count_by_year
  end

  def record_updatable_params(params)
    params[:artist_name].present? ? {name: params[:artist_name]} : {}
  end
end
