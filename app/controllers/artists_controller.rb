class ArtistsController < ApplicationController
  def show
    artist = Artist.find(params[:id])

    render json: artist
  end
end
