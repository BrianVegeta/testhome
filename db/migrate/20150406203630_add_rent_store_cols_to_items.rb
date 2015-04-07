class AddRentStoreColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :decorating_level, :string
  end
end
