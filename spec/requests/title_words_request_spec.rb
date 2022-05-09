require "rails_helper"

RSpec.describe "TitleWords", type: :request do
  describe "index" do
    let(:headers) { {"ACCEPT" => "application/json"} }

    it "successfully handles request" do
      get "/title_words", headers: headers

      expect(response).to have_http_status(:ok)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.size).to eq(0)
    end

    context "with valid album titles" do
      before { create_list(:record, 100) }
      it "returns a descending list of the most common words in album titles" do
        get "/title_words", headers: headers

        parsed_body = JSON.parse(response.body)
        expect(parsed_body.size).to eq(50)
        expect(parsed_body.first["word"]).to be_a(String)
        expect(parsed_body.first["count"]).to be_a(Integer)
      end
    end
  end
end
