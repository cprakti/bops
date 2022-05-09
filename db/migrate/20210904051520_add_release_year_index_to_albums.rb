class AddReleaseYearIndexToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :release_year
  end
end
