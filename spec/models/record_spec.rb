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
require "rails_helper"

RSpec.describe Record, type: :model do
  describe "validations" do
    it { should validate_presence_of(:condition) }
    it { should validate_numericality_of(:condition).is_less_than_or_equal_to(10) }
    it { should validate_numericality_of(:condition).is_greater_than_or_equal_to(0) }
  end

  describe "associations" do
    it { should belong_to(:album) }
    it { should have_one(:artist) }
  end

  describe ".where_title" do
    let(:album1_name) { "Hello" }
    let(:album1) { create(:album, title: album1_name) }
    let!(:record1) { create(:record, album: album1) }
    let(:album2) { create(:album, title: "Goodbye") }
    let!(:record2) { create(:record, album: album2) }

    context "when a valid query is passed" do
      let(:query) { album1_name }
      it "returns matching records" do
        result = Record.where_title(query)
        expect(result).to eq([record1])
      end
    end

    context "when a empty query is passed" do
      let(:query) { "" }
      it "returns all records" do
        result = Record.where_title(query)
        expect(result.length).to eq(2)
      end
    end
  end

  describe "#artist_name" do
    let(:artist_name) { "Bruce Springsteen" }
    let(:artist) { create(:artist, name: artist_name) }
    let(:album) { create(:album, artist: artist) }
    let(:record) { create(:record, album: album) }

    it "returns the related artist" do
      expect(record.artist_name).to eq(artist_name)
    end
  end

  describe "#title" do
    let(:title) { "Funeral" }
    let(:album) { create(:album, title: title) }
    let(:record) { create(:record, album: album) }

    it "returns the related artist" do
      expect(record.title).to eq(title)
    end
  end

  describe "#release_year" do
    let(:release_year) { 1999 }
    let(:album) { create(:album, release_year: release_year) }
    let(:record) { create(:record, album: album) }

    it "returns the related artist" do
      expect(record.release_year).to eq(release_year)
    end
  end

  describe "#related_by_album" do
    let!(:album) { create(:album) }
    let!(:record1) { create(:record, album: album) }
    let!(:record2) { create(:record, album: album) }

    it "returns record ids related by album" do
      expect(record1.related_by_album).to eq([record2.id])
    end
  end

  describe "#related_by_artist" do
    let!(:artist) { create(:artist) }
    let!(:album1) { create(:album, artist: artist) }
    let!(:album2) { create(:album, artist: artist) }
    let!(:record1) { create(:record, album: album1) }
    let!(:record2) { create(:record, album: album2) }

    it "returns record ids related by artist" do
      expect(record1.related_by_artist).to eq([record2.id])
    end
  end

  describe "#record_updatable_params" do
    let(:record) { create(:record) }

    context "with relevant params" do
      let(:condition) { 10 }
      let(:notes) { "Meh" }
      let(:params) { {foo: :bar, condition: condition, notes: notes} }

      it "returns a hash of related params for update" do
        result = record.record_updatable_params(params)
        expect(result).to eq({condition: condition, notes: notes})
      end
    end

    context "with irrelevant params" do
      let(:params) { {foo: :bar} }

      it "returns an empty hash" do
        result = record.record_updatable_params(params)
        expect(result).to eq({})
      end
    end
  end
end
