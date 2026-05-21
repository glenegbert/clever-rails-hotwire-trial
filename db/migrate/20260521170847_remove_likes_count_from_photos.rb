class RemoveLikesCountFromPhotos < ActiveRecord::Migration[8.1]
  def change
    remove_column :photos, :likes_count, :integer
  end
end
