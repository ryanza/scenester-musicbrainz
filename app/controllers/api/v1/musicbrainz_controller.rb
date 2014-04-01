class Api::V1::MusicbrainzController < ApplicationController
  def search
    search = params[:q]
    render json: Tire.search(Musicbrainz::Track.index_name){size 9000; query{string search}}.results
  end
end
