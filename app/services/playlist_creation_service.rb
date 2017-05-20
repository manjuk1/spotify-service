class PlaylistCreationService
  
  attr_reader :artist_name, :list, :recent_concert
  
  def initialize artist_name
    @artist_name = artist_name
    @list = []
  end

  def create
    @recent_concert = RecentConcertReadService.new(artist_name).read
    sets = read_sets
    if sets
      sets.each do |song|
        song["song"].each do |sub_song|
          metadata = MetadataReadService.new(artist_name, sub_song["@name"]).read
          list << metadata if metadata
        end
      end
    end
    list
  end

  private

  def read_sets
    recent_concert["sets"]["set"] ? recent_concert["sets"]["set"] : false
  end

end