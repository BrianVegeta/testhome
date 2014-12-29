class MergeTags < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute('UPDATE taggings SET context = "addons" WHERE context != "tags";');
    ActiveRecord::Base.connection.execute('UPDATE items SET floor_select = REPLACE(floor_select, "|", " ") , floor_room_number = REPLACE(floor_room_number, "|", " ")');
    add_column :items , :old_year , :integer , :limit => 2
    add_column :items , :old_month , :integer , :limit => 1
  end

  def self.down
    #不可逆
    make_error
  end
end
