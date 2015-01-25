class AddColsToStyles < ActiveRecord::Migration
  def change
  	add_column :styles, :description, :string
  end
end
