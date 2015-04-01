class ChangeItemsFloorType < ActiveRecord::Migration
  def up
    change_column :items, :current_floor, :string
  end
  def down
    change_column :items, :current_floor, :integer
  end
end
