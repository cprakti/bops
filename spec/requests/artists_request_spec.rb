require "rails_helper"

RSpec.describe "Artists", type: :request do
  let(:headers) { {"ACCEPT" => "application/json"} }

  describe "show" do
    context "for valid requests" do
      let(:artist1) { create(:artist) }
      let!(:album1) { create(:album, release_year: 2000, artist: artist1) }
      let!(:album2) { create(:album, release_year: 2001, artist: artist1) }
      let!(:album3) { create(:album, release_year: 2002, artist: artist1) }
      let!(:album4) { create(:album, release_year: 2002, artist: artist1) }
      let(:artist2) { create(:artist) }
      let!(:album5) { create(:album, release_year: 2000, artist: artist2) }

      it "successfully handles the request" do
        get "/artists/#{artist1.id}", headers: headers

        expect(response).to have_http_status(:ok)
      end

      it "returns details on the artist" do
        get "/artists/#{artist1.id}", headers: headers

        parsed_body = JSON.parse(response.body).symbolize_keys
        expect(parsed_body[:id]).to eq(artist1.id)
        expect(parsed_body[:name]).to eq(artist1.name)
        expect(parsed_body[:releases_by_year]).to eq({
          "2000" => 1,
          "2001" => 1,
          "2002" => 2
        })
      end
    end

    context "for invalid requests" do
    end
  end
end
