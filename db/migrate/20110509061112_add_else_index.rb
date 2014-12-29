class AddElseIndex < ActiveRecord::Migration
  def self.up
    add_index "items", ["accessories"], :name => "accessories"
    add_index "join_requests", ["type"], :name => "type"
    add_index "join_requests", ["target_type"], :name => "target_type"
    add_index "join_requests", ["target_id"], :name => "target_id"
    add_index "join_requests", ["from_user_id"], :name => "from_user_id"
    add_index "join_requests", ["from_org_id"], :name => "from_org_id"
    add_index "join_requests", ["to_user_id"], :name => "to_user_id"
    add_index "join_requests", ["to_org_id"], :name => "to_org_id"
    add_index "join_requests", ["maked_type"], :name => "maked_type"
    add_index "join_requests", ["maked_id"], :name => "maked_id"
    add_index "join_requests", ["status"], :name => "status"
  end

  def self.down
    remove_index "items", :name => "accessories"
    remove_index "join_requests", :name => "type"
    remove_index "join_requests", :name => "target_type"
    remove_index "join_requests", :name => "target_id"
    remove_index "join_requests", :name => "from_user_id"
    remove_index "join_requests", :name => "from_org_id"
    remove_index "join_requests", :name => "to_user_id"
    remove_index "join_requests", :name => "to_org_id"
    remove_index "join_requests", :name => "maked_type"
    remove_index "join_requests", :name => "maked_id"
    remove_index "join_requests", :name => "status"
  end
end