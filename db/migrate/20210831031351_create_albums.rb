class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :release_year
      t.references :artist

      t.timestamps
    end
  end
end
