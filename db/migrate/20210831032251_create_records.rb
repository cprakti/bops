class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.integer :condition, null: false, inclusion: {in: 0..10}
      t.text :notes
      t.integer :album_id

      t.timestamps
    end
  end
end
