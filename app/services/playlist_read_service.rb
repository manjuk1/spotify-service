class PlaylistReadService < BaseService

  include ActiveModel::Validations
  
  validate :artist_name?
  validate :concert_date?

  attr_reader :artist_name, :concert_date

  def initialize artist_name, concert_date
    super()
    @artist_name = artist_name
    @concert_date = concert_date
  end

  def read
    if valid?
      if artist_name.present? && concert_date.present?
        fetch_tracks
      else
        (list = create_tracks) ? list.tracks : false
      end
    else
      build_validation_error(self)
      set_response_status(:unprocessable_entity)
      false
    end
  rescue Exception => error
    build_exception_error(error)
    set_response_status(:unprocessable_entity)
    false
  end

  private
  
  def artist_name?
    errors.add(:artist_name , "cannot be blank. Please enter the artist name") unless artist_name.present?
  end

  def concert_date?
    errors.add(:concert_date , "invalid. Please enter valid date") if concert_date.present? && !concert_date_valid?
  end

  def concert_date_valid?
    Date.parse(concert_date)
  rescue Exceprion => error
    false
  end

  def create_tracks
    PlaylistCreationService.new(artist_name).create
  end

  def fetch_tracks
    list = Playlist.where(artist_name: artist_name, concert_date: Date.parse(concert_date).beginning_of_day..Date.parse(concert_date).end_of_day).first
    list ? list.tracks : []
  end
  
end