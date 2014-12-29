class Item < ActiveRecord::Base ; end
class ChangeItemEndAtDefaultValue < ActiveRecord::Migration
  def self.up
    #"2036/05/28_09:26:58"
    change_column :items , :end_at , :datetime , :default => nil, :null => true
    remove_column :items , :start_at
    Item.update_all("end_at = NULL" , "DATE(end_at) >= DATE('2030/01/21')")
  end

  def self.down
    change_column :items , :end_at , :datetime , :default => '3000-01-01 00:00:00', :null => false
    add_column :items , :start_at , :datetime
    #no date undo
  end
end