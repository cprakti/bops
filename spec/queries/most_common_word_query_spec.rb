require "rails_helper"

RSpec.describe MostCommonWordsQuery, type: :query do
  describe "#search" do
    album_details = {
      "Nickelback" => 5,
      "Beatles" => 10,
      "Eagles" => 15,
      "Nirvana" => 20
    }

    before do
      album_details.map do |title, count|
        create_list(:album, count, title: title)
      end
    end

    it "returns top 50 most common words in album titles" do
      result = MostCommonWordsQuery.new.search

      expect(result[0]).to eq(word: "nirvana", count: 20)
      expect(result[1]).to eq(word: "eagles", count: 15)
      expect(result[2]).to eq(word: "beatles", count: 10)
      expect(result[3]).to eq(word: "nickelback", count: 5)
    end
  end
end
