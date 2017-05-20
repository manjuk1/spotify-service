class SetlistSearchApiService < BaseApiService

  attr_reader :artist_name
  
  def initialize artist_name
    @artist_name = artist_name
    super(url)
  end

  private

  def url
    "#{Constants::SETLIST_FM_BASE_URL}#{Constants::SETLIST_FM_URIS[:search]}.json?#{query_param}"
  end

  def query_param
    "artistName=#{artist_name}"
  end
  
end