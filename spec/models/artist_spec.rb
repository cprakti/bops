# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Artist, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:albums) }
    it { should have_many(:records) }
  end

  describe "#releases_by_year" do
    let(:artist) { create(:artist) }
    context "with related albums" do
      let!(:album) { create(:album, artist: artist) }
      let(:other_artist) { create(:artist) }
      let!(:other_album) { create(:album, artist: other_artist) }

      it "returns count of artist's albums grouped by year" do
        result = artist.releases_by_year
        expect(result).to eq({album.release_year => 1})
      end
    end

    context "without related albums" do
      it "returns an empty hash" do
        result = artist.releases_by_year
        expect(result).to eq({})
      end
    end
  end

  describe "#record_updatable_params" do
    let(:artist) { create(:artist) }

    context "with relevant params" do
      let(:artist_name) { "Jimmy Eat World" }
      let(:params) { {foo: :bar, artist_name: artist_name} }

      it "returns a hash of related params for update" do
        result = artist.record_updatable_params(params)
        expect(result).to eq({name: artist_name})
      end
    end

    context "with irrelevant params" do
      let(:params) { {foo: :bar} }

      it "returns an empty hash" do
        result = artist.record_updatable_params(params)
        expect(result).to eq({})
      end
    end
  end
end
