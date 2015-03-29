class CreateItemStreet < ActiveRecord::Migration
  def change
    create_table :item_streets do |t|
      t.string  :name
      t.integer :main_area
      t.integer :sub_area
      
      t.timestamps
    end
  end
end
