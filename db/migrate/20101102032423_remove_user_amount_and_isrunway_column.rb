class RemoveUserAmountAndIsrunwayColumn < ActiveRecord::Migration
  def self.up
    remove_column :users , :amount
    remove_column :users , :is_runway
  end

  def self.down
    add_column :users , :amount , :decimal , :precision => 10, :scale => 0 , :default => 0 , :null => false
    add_column :users , :is_runway , :boolean , :default => false , :null => false
  end
end