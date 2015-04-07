class AddRentPlaceColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :place_type,   :string
    add_column :items, :place_usage,  :text
    
    add_column :items, :place_capacity,   :string
    add_column :items, :place_price_type, :string
    add_column :items, :manager_type,     :string
  end
end
