require "rails_helper"

RSpec.describe RecordUpdate, type: :service do
  describe "#perform" do
    let(:record) { create(:record) }

    context "with valid params" do
      let(:params) do
        {
          id: record.id,
          artist_name: artist_name,
          condition: condition,
          title: title,
          release_year: release_year
        }
      end

      context "with params that does not cause any update" do
        let(:artist_name) { record.artist_name }
        let(:condition) { record.condition }
        let(:title) { record.title }
        let(:release_year) { record.release_year }

        it "does not update any value" do
          RecordUpdate.new(params).perform
          record.reload

          expect(record.artist_name).to eq(artist_name)
          expect(record.condition).to eq(condition)
          expect(record.title).to eq(title)
          expect(record.release_year).to eq(release_year)
        end
      end

      context "with params that update artist, album, and record" do
        let(:artist_name) { "Outkast" }
        let(:condition) { 7 }
        let(:title) { "Stankonia" }
        let(:release_year) { 2001 }

        it "updates respective values on artist, album, and record" do
          expect(record.artist_name).not_to eq(artist_name)
          expect(record.condition).not_to eq(condition)
          expect(record.title).not_to eq(title)
          expect(record.release_year).not_to eq(release_year)

          RecordUpdate.new(params).perform
          record.reload

          expect(record.artist_name).to eq(artist_name)
          expect(record.condition).to eq(condition)
          expect(record.title).to eq(title)
          expect(record.release_year).to eq(release_year)
        end
      end
    end

    context "with invalid params" do
      context "when params are nil" do
        let(:params) { nil }

        it "returns an ArgumentError" do
          expect { RecordUpdate.new(params).perform }.to raise_error(BadRecordUpdate)
        end
      end
    end
  end
end
