class MetadataReadService

  attr_reader :artist_name, :track_name
 
  def initialize artist_name, track_name
    @artist_name = artist_name
    @track_name = track_name
  end

  def read
    track = search_track
    if track
      release_year = get_release_year(track["album"]["id"])
      fetch_metadata(track, release_year)
    end
  rescue Exception => error 
    Rails.logger.info "MetadataReadServiceError: Unable to get metadata for track #{track_name}"
    Rails.logger.info error.backtrace.join("\n")
    false
  end

  private
  
  def search_track
    # I see same track across albums with different values for  duration_ms, 
    # Not sure which track I should pick up. Hence reading the metadata from the first match 
    response = SpotifySearchApiService.new(artist_name, track_name).request
    first_matching_track(response)
  end

  def get_release_year album_id
    response = AlbumDetailsApiService.new(album_id).request
    year =  case response["release_date_precision"]
            when "day" 
              Date.parse(response["release_date"]).year
            when "year" 
              response["release_date"]
            else
              nil
            end
    year
  end

  def fetch_metadata track, release_year
    {
      spotify_id: track["id"],
      artist_name: artist_name,
      track_name: track["name"],
      duration_ms: track["duration_ms"],
      album_name: track["album"]["name"],
      isrc: track["external_ids"]["isrc"],
      release_year: release_year
    }
  end

  def first_matching_track response
    if response["tracks"].present? && response["tracks"]["items"].present?
      response["tracks"]["items"].detect do |item|
        item["name"] == track_name && item["artists"].collect { |artst| artst["name"] == artist_name}.any?
      end
    end
  end

end
