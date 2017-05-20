class RecentConcertReadService
  
  attr_reader :artist_name

  def initialize artist_name
    @artist_name = artist_name
  end

  def read
    recent_concert(concerts)
  rescue Exception => error 
    Rails.logger.info "RecentConcertSetlistReadservice: Unable to get setlist for artist #{artist_name}"
    Rails.logger.info error.backtrace.join("\n")
    false
  end

  private

  def recent_concert response
    response["setlists"]["setlist"].empty? ? nil : response["setlists"]["setlist"][0] 
  end

  def concerts
    @_response ||= SetlistSearchApiService.new(artist_name).request
  end
end