require "rails_helper"

RSpec.describe "Records", type: :request do
  describe "index" do
    let(:parsed_body) { JSON.parse(response.body) }
    let(:headers) { {"ACCEPT" => "application/json"} }

    context "with a record to return" do
      let!(:record1) { create(:record) }

      it "returns a record" do
        get "/records", headers: headers

        expect(response).to have_http_status(:ok)
        expect(parsed_body.first["id"]).to eq(record1[:id])
      end

      it "each record returned includes the required fields" do
        get "/records", headers: headers

        parsed_body.each do |record|
          expect(record.symbolize_keys.keys).to contain_exactly(*[RecordUpdate::REQUIRED_KEY] + RecordUpdate::VALID_KEYS)
        end
      end
    end

    context "when a query param is present" do
      let(:album_title1) { "OK Computer" }
      let(:album_title2) { "OK GO" }
      let(:album_title3) { "No Doubt" }
      let(:album1) { create(:album, title: album_title1) }
      let(:album2) { create(:album, title: album_title2) }
      let(:album3) { create(:album, title: album_title3) }
      let(:albums) { [album1, album2, album3] }

      before { albums.each { |album| create_list(:record, 3, album: album) } }

      it "returns records that match the title query" do
        get "/records", headers: headers, params: {query: "OK"}

        expect(response).to have_http_status(:ok)
        expect(parsed_body.size).to eq(6)
        expect(parsed_body[0]["title"]).to eq(album_title1)
        expect(parsed_body[1]["title"]).to eq(album_title1)
        expect(parsed_body[2]["title"]).to eq(album_title1)
        expect(parsed_body[3]["title"]).to eq(album_title2)
        expect(parsed_body[4]["title"]).to eq(album_title2)
        expect(parsed_body[5]["title"]).to eq(album_title2)
      end

      context "when nothing matches the query" do
        it "returns an empty array" do
          get "/records", headers: headers, params: {query: "ZZZ"}

          expect(parsed_body.size).to eq(0)
        end
      end

      context "when an empty query is passed" do
        it "returns all records" do
          get "/records", headers: headers, params: {query: ""}

          expect(parsed_body.size).to eq(9)
        end
      end
    end

    context "when paginating is needed" do
      before do
        create_list(:record, 26)
      end

      it "returns 25 results as a default" do
        get "/records", headers: headers

        expect(parsed_body.size).to eq(25)
      end

      context "when a page is specified" do
        it "returns records on that page" do
          get "/records", params: {page: 2}, headers: headers

          expect(parsed_body.size).to eq(1)
          expect(parsed_body.first["id"]).to eq(Record.last.id)
        end
      end

      context "when a specific amount per page is requested" do
        it "returns the specified amount of records" do
          get "/records", params: {page: 2, per_page: 10}, headers: headers

          expect(parsed_body.size).to eq(10)
        end
      end
    end
  end

  describe "create" do
    let(:headers) { {"Content-Type" => "multipart/form-data"} }
    let(:upload_file) { Rack::Test::UploadedFile.new(csv_file) }
    let(:params) { {file: upload_file} }
    let(:parsed_body) { JSON.parse(response.body).symbolize_keys }
    context "with a valid request" do
      let(:csv_file) { File.new(fixture_path + "/records.csv") }

      it "successfully handles the request" do
        post "/records", headers: headers, params: params

        expect(response).to have_http_status(:created)
      end

      context "with a valid CSV" do
        context "with all valid rows" do
          it "returns the number of records ingested and error counts" do
            post "/records", headers: headers, params: params

            expect(parsed_body[:records_added]).to eq(3)
            expect(parsed_body[:errors]).to eq({})
          end

          context "when albums and artists already exist" do
            let(:duplicate_file) { Rack::Test::UploadedFile.new(csv_file) }
            it "finds existing albums, and artists" do
              post "/records", headers: headers, params: params

              expect(Record.count).to eq(3)
              expect(Artist.count).to eq(2)
              expect(Album.count).to eq(3)

              post "/records", headers: headers, params: {file: duplicate_file}
              expect(parsed_body[:records_added]).to eq(3)
              expect(parsed_body[:errors]).to eq({})
              expect(Record.count).to eq(6)
              expect(Artist.count).to eq(2)
              expect(Album.count).to eq(3)
            end
          end
        end

        context "with some invalid rows" do
          let(:csv_file) { File.new(fixture_path + "/some_bad_records.csv") }
          it "returns the number of records ingested and error counts" do
            post "/records", headers: headers, params: params

            expect(parsed_body[:records_added]).to eq(2)
            expect(parsed_body[:errors]).to eq({
              "Validation failed: Condition can't be blank, Condition is not a number" => 1
            })
          end
        end
      end

      context "with an invalid CSV" do
        let(:csv_file) { File.new(fixture_path + "/empty.csv") }
        it "returns the number of records ingested and error counts" do
          post "/records", headers: headers, params: params

          expect(response).to have_http_status(:bad_request)
          expect(parsed_body[:error]).to include(RecordsFile::MISSING_HEADERS_STEM)
        end
      end
    end

    context "with an invalid request" do
      it "returns the number of records ingested and error counts" do
        post "/records", headers: headers

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body[:error]).to include("param is missing or the value is empty: file")
      end
    end
  end

  describe "update" do
    let(:parsed_body) { JSON.parse(response.body).symbolize_keys }
    let(:deep_symbolized_parsed_body) { JSON.parse(response.body).deep_symbolize_keys }
    let(:headers) { {"ACCEPT" => "application/json"} }
    let!(:record_to_update) { create(:record, condition: 1) }

    context "for valid requests" do
      let(:params) { {condition: 10} }
      let(:related_records) do
        {
          by_album: by_album,
          by_artist: by_artist
        }
      end
      let(:by_album) { [] }
      let(:by_artist) { [] }

      it "successfully handles the request" do
        patch "/records/#{record_to_update.id}", params: params, headers: headers

        expect(response).to have_http_status(:ok)
      end

      it "returns expected fields" do
        patch "/records/#{record_to_update.id}", params: params, headers: headers

        expect(deep_symbolized_parsed_body[:artist_name]).to eq(record_to_update.artist.name)
        expect(deep_symbolized_parsed_body[:condition]).to eq(10)
        expect(deep_symbolized_parsed_body[:id]).to eq(record_to_update.id)
        expect(deep_symbolized_parsed_body[:title]).to eq(record_to_update.title)
        expect(deep_symbolized_parsed_body[:release_year]).to eq(record_to_update.release_year)
        expect(deep_symbolized_parsed_body[:related_records]).to eq(related_records)
      end

      context "with no new fields" do
        let(:params) do
          {
            artist_name: record_to_update.artist.name,
            condition: record_to_update.condition,
            release_year: record_to_update.release_year,
            title: record_to_update.title
          }
        end
        let(:expected_response) do
          {
            artist_name: record_to_update.artist.name,
            condition: record_to_update.condition,
            id: record_to_update.id,
            release_year: record_to_update.release_year,
            title: record_to_update.title,
            related_records: related_records
          }
        end

        it "updates records and returns the serialized record details" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(parsed_body.deep_symbolize_keys).to eq(expected_response)
        end
      end

      context "with all new fields" do
        let(:updated_artist_name) { "Ben Folds" }
        let(:updated_condition) { 8 }
        let(:updated_title) { "Rockin' the Suburbs" }
        let(:updated_release_year) { 2001 }

        let(:params) do
          {
            artist_name: updated_artist_name,
            condition: updated_condition,
            release_year: updated_release_year,
            title: updated_title
          }
        end
        let(:expected_response) do
          {
            artist_name: updated_artist_name,
            condition: updated_condition,
            id: record_to_update.id,
            release_year: updated_release_year,
            title: updated_title,
            related_records: related_records
          }
        end

        it "updates records and returns the serialized record details" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(deep_symbolized_parsed_body).to eq(expected_response)
        end
      end

      context "when related records exist" do
        let(:different_album) { create(:album, artist: record_to_update.artist) }
        let!(:by_album) { [create(:record, album: record_to_update.album).id] }
        let!(:by_artist) { by_album + [create(:record, album: different_album).id] }

        let(:expected_response) do
          {
            artist_name: record_to_update.artist_name,
            condition: 10,
            id: record_to_update.id,
            release_year: record_to_update.release_year,
            title: record_to_update.title,
            related_records: related_records
          }
        end

        it "returns related record ids by artist and by album" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(deep_symbolized_parsed_body).to eq(expected_response)
        end
      end
    end

    context "for invalid requests" do
      context "with no params" do
        let(:params) { nil }

        it "returns bad request error and message" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(response).to have_http_status(:bad_request)
          expect(parsed_body[:error]).to eq(RecordUpdate::BAD_RECORD_UPDATE_MESSAGE)
        end
      end

      context "with insufficient params" do
        let(:params) { {} }

        it "returns bad request error and message" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(response).to have_http_status(:bad_request)
          expect(parsed_body[:error]).to eq(RecordUpdate::BAD_RECORD_UPDATE_MESSAGE)
        end
      end

      context "with extra values in the payload" do
        let(:artist_name) { "Tobias Funke" }
        let(:params) do
          {
            artist_name: artist_name,
            foo: "bar"
          }
        end

        it "ignores extra parameters and updates records" do
          patch "/records/#{record_to_update.id}", params: params, headers: headers

          expect(response).to have_http_status(:ok)
          expect(parsed_body[:artist_name]).to eq(artist_name)
        end
      end
    end
  end
end
