class SpotifySearchApiService < BaseApiService

  attr_reader :artist, :track
  
  def initialize artist, track
    @artist = artist
    @track = track
    super(url)
  end

  private

  def url
    "#{Constants::SPOTIFY_BASE_URL}#{Constants::SPOTIFY_URIS[:search]}?#{query_param}"
  end

  def query_param
    "q=artist:#{artist} track:#{track}&type=track"
  end

end