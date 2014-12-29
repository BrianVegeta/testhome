class PrefixInit < ActiveRecord::Migration
  def self.up
    #起點使用mysql語法："delete from schema_migrations where version > 20100101010101"
    #此表為初始修正於初版v2的差異點，且無down
    #source_fix
    remove_column :items , :boolean
    remove_index :items, :name => "items_end_at"
    #convert_fix
    change_column :blogs , :body , :text , :limit => 2147483647
    change_column :blogs , :content , :text , :limit => 2147483647
    change_column :item_flags , :user_id , :integer , :null => true
    change_column :items , :floor_select , :text , :limit => 512
    change_column :items , :floor_room_number , :text , :limit => 1024
    change_column :maps , :owner_id , :integer , :null => false
    change_column :maps , :owner_type , :string , :limit => 30 , :null => false
    change_column :maps , :lng , :double , :default => 0.0, :null => false , :limit => 25
    change_column :maps , :lat , :double , :default => 0.0, :null => false , :limit => 25
    add_column :organization_authorizations , :created_at , :datetime
    add_column :organization_authorizations , :updated_at , :datetime
    change_column :places , :lng , :double , :default => 0.0, :null => false , :limit => 25
    change_column :places , :lat , :double , :default => 0.0, :null => false , :limit => 25
    remove_index :posts, :name => "lft"
  end
end
