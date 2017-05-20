class AlbumDetailsApiService < BaseApiService

  attr_reader :album_id
  
  def initialize album_id
    @album_id = album_id
    super(url)
  end

  private

  def url
    "#{Constants::SPOTIFY_BASE_URL}#{Constants::SPOTIFY_URIS[:album]}/#{album_id}"
  end
  
end