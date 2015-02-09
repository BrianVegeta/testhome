class AddLevelCountToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :level_count, 	:integer
  	add_column :organizations, :is_root, 			:boolean
  end
end
