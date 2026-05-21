class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :photographer, null: false
      t.string :src_medium, null: false
      t.string :source_url, null: false
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
