class Playlist < ApplicationRecord
  has_and_belongs_to_many :tracks

  validates_presence_of :concert_date, :artist_name

  validates :concert_date, uniqueness: {scope: :artist_name}
end
