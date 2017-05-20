class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist_name
      t.string :album_name
      t.integer :duration_ms
      t.string :isrc
      t.string :release_year
      t.string :spotify_id

      t.timestamps
    end
  end
end
