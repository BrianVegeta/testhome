class AddColumnsForNested < ActiveRecord::Migration
  def change
  	add_column :organizations, :depth, 					:integer
  	add_column :organizations, :children_count, :integer
  end
end
