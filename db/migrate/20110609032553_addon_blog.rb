class AddonBlog < ActiveRecord::Migration
  #Blog模式附加
  def self.up
    add_column :blogs , :signed , :boolean , :default => false , :null => false #特殊標記，置頂
    add_column :blogs , :hidden , :boolean , :default => false , :null => false #是否隱藏
  end

  def self.down
    remove_column :blogs , :signed
    remove_column :blogs , :hidden
  end
end