class PlaylistsController < ApplicationController

  def index
    svc = PlaylistReadService.new(index_params[:artist_name], index_params[:concert_date])
    if tracks = svc.read
      render json: tracks
    else
      render json: {message: svc.error[:message]}, status: svc.response_status
    end
  end

  private

  def index_params
    params.permit(:artist_name, :concert_date)
  end

end
