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
FactoryBot.define do
  factory :album do
    artist
    release_year { 2000 }
    title { Faker::Music.album }
  end
end
