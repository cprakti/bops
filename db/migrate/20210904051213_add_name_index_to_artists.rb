class AddNameIndexToArtists < ActiveRecord::Migration[6.0]
  def change
    add_index :artists, :name
  end
end
