class Api::V1::MusicbrainzController < ApplicationController
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  respond_to :json

  def search
    search = params[:q]
    page = params[:page] || 1
    per_page = params[:per_page] || 20

    if search.blank?
      render :nothing => true, :status => 400
    else
      @tracks = Musicbrainz::Track.api_search(search, page, per_page)

      respond_with(@tracks)
    end
  end
end
