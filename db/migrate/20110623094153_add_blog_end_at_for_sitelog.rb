class AddBlogEndAtForSitelog < ActiveRecord::Migration
  def self.up
    add_column :blogs , :end_at , :date #限定date，因要求為"截止日"，因此可以用 Date.now > end_at來做判定
  end

  def self.down
    remove_column :blogs , :end_at , :date
  end
end
