class AddRentSuitColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :pattern_entresol_has, :boolean
    add_column :items, :sexual_require,       :string
  end
end
