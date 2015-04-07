class AddPhotoIdsToItems < ActiveRecord::Migration
  def change
    add_column :items, :photo_ids,          :text
    add_column :items, :new_photo_pattern,  :boolean
  end
end
