class PlaylistCreationService
  
  attr_reader :artist_name, :recent_concert
  
  def initialize artist_name
    @artist_name = artist_name
  end

  def create
    @recent_concert = RecentConcertReadService.new(artist_name).read
    @list = Playlist.where(artist_name: artist_name, 
                                            concert_date: Date.parse(recent_concert["@eventDate"]).beginning_of_day..Date.parse(recent_concert["@eventDate"]).end_of_day).first
    return @list if @list.present? && @list.tracks.count > 0
    unless @list.present?
      @list = Playlist.new(artist_name: artist_name, 
                                            concert_date: Date.parse(recent_concert["@eventDate"]).beginning_of_day)
    end
    sets = read_sets
    if sets
      sets.each do |set|
        if set["song"].present? && set["song"].kind_of?(Array)
          set["song"].each do |song|
            metadata = MetadataReadService.new(artist_name, song["@name"]).read
            @list.tracks.build(metadata) if metadata 
          end
        end
      end
    end
    @list.save!
    @list
  end

  private

  def read_sets
    recent_concert["sets"]["set"] ? recent_concert["sets"]["set"] : false
  end

end