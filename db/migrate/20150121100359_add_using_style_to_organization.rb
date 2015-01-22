class AddUsingStyleToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :using_style, :string
  end
end
