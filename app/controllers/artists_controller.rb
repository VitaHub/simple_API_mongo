class ArtistsController < ApplicationController
  	def index
  		@artists = Artist.all
		render json: @artists
  	end

  	def show
  		@albums = {"artist": Artist.find_by(itunes_id: params[:id]),"albums": Artist.find_by(itunes_id: params[:id]).albums}
		render json: @albums
  	end
end
