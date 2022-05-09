class AddTitleIndexToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :title
  end
end
