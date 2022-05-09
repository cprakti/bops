class TitleWordsController < ApplicationController
  def index
    results = MostCommonWordsQuery.new.search

    render json: results
  end
end
