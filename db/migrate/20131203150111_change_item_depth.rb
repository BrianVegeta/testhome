class ChangeItemDepth < ActiveRecord::Migration
  def self.up
    change_column :items , :depth , :string
  end
  def self.down
    change_column :items , :depth , :integer
  end
end
