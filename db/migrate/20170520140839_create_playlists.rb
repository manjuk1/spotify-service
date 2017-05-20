class CreatePlaylists < ActiveRecord::Migration[5.1]
  def change
    create_table :playlists do |t|
      t.string :artist_name
      t.datetime :concert_date

      t.timestamps
    end
  end
end
