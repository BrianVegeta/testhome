class AddDepthToOrganizationAauths < ActiveRecord::Migration
  def change
  	add_column :organization_auths, :depth, 					:integer
  	add_column :organization_auths, :children_count, 	:integer
  end
end
