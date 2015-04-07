class AddParkingColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :parking_cate, :string
    add_column :items, :parking_type, :string
  end
end
