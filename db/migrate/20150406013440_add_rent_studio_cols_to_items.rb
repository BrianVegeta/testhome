class AddRentStudioColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :partition_material, :string
    add_column :items, :addition_rooms,     :text
  end
end
