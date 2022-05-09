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
require "rails_helper"

RSpec.describe Album, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "associations" do
    it { should belong_to(:artist) }
    it { should have_many(:records) }
  end

  describe ".count_by_year" do
    let(:release_year1) { 2000 }
    let(:album_count1) { 5 }
    let(:release_year2) { 1999 }
    let(:album_count2) { 3 }
    let(:album_data) do
      [
        [release_year1, album_count1],
        [release_year2, album_count2]
      ]
    end

    before do
      album_data.each { |release_year, count| create_list(:album, count, release_year: release_year) }
    end

    it "returns albums grouped by year" do
      result = Album.count_by_year
      expect(result).to eq({
        release_year1 => album_count1,
        release_year2 => album_count2
      })
    end
  end

  describe "#record_updatable_params" do
    let(:album) { create(:album) }

    context "with relevant params" do
      let(:title) { "Abbey Road" }
      let(:release_year) { 1969 }
      let(:params) { {foo: :bar, title: title, release_year: release_year} }

      it "returns a hash of related params for update" do
        result = album.record_updatable_params(params)
        expect(result).to eq({title: title, release_year: release_year})
      end
    end

    context "with irrelevant params" do
      let(:params) { {foo: :bar} }

      it "returns an empty hash" do
        result = album.record_updatable_params(params)
        expect(result).to eq({})
      end
    end
  end
end
