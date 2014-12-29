class AddIndexForFullTable < ActiveRecord::Migration
  def self.up
    #remove nonuse_column & index
      remove_column :order_plans , :parent_id #已改order_plan_renewals
    #remove nonuse_column & index
    add_index "adrands", ["ad_id"], :name => "ad_id"
    add_index "adrands", ["adgroup_id"], :name => "adgroup_id"
    add_index "adrands", ["organization_id"], :name => "organization_id"
    add_index "ads", ["organization_id"], :name => "organization_id"
    add_index "blogs", ["type"], :name => "type"
    add_index "blogs", ["user_id"], :name => "user_id"
    add_index "commissions", ["owner_type"], :name => "owner_type"
    add_index "commissions", ["owner_id"], :name => "owner_id"
    add_index "commissions", ["end_at"], :name => "end_at"
    add_index "commissions", ["main"], :name => "main"
    add_index "commissions", ["from_id"], :name => "from_id"
    add_index "commissions", ["from_type"], :name => "from_type"
    add_index "commissions", ["sub"], :name => "sub"
    add_index "domains", ["organization_id"], :name => "organization_id"
    add_index "item_alerms", ["owner_id"], :name => "owner_id"
    add_index "item_alerms", ["owner_type"], :name => "owner_type"
    add_index "item_alerms", ["item_flag_id"], :name => "item_flag_id"
    add_index "item_partakes", ["kind"], :name => "kind"
    add_index "item_partakes", ["trans"], :name => "trans"
    add_index "items", ["type"], :name => "type"
    add_index "items", ["owner_type"], :name => "owner_type"
    add_index "items", ["sale_kind"], :name => "sale_kind"
    add_index "items", ["unique_number"], :name => "unique_number"
    add_index "items", ["lft"], :name => "lft"
    add_index "items", ["is_org_close"], :name => "is_org_close"
    add_index "maps", ["owner_type"], :name => "owner_type"
    add_index "maps", ["temp_key"], :name => "temp_key"
    add_index "member_lists", ["module_set_id"], :name => "module_set_id"
    add_index "member_lists", ["target_type"], :name => "target_type"
    add_index "member_lists", ["target_id"], :name => "target_id"
    add_index "member_lists", ["showon_portlet"], :name => "showon_portlet"
    add_index "member_lists", ["showon_module"], :name => "showon_module"
    add_index "messages", ["status"], :name => "status"
    add_index "messages", ["kind"], :name => "kind"
    add_index "messages", ["created_at"], :name => "created_at"
    add_index "messages", ["from_type"], :name => "from_type"
    add_index "messages", ["level_kind"], :name => "level_kind"
    add_index "mobile_messages", ["created_at"], :name => "created_at"
    add_index "mobile_messages", ["status"], :name => "status"
    add_index "mobile_messages", ["user_id"], :name => "user_id"
    add_index "mobile_messages", ["message_id"], :name => "message_id"
    add_index "mobile_messages", ["pay_from_org_id"], :name => "pay_from_org_id"
    add_index "module_sets", ["parent_id"], :name => "parent_id"
    add_index "module_sets", ["hidden"], :name => "hidden"
    add_index "module_sets", ["display_column"], :name => "display_column"
    add_index "module_sets", ["addon_site"], :name => "addon_site"
    add_index "order_groups", ["showon_user"], :name => "showon_user"
    add_index "order_groups", ["showon_personal"], :name => "showon_personal"
    add_index "order_groups", ["showon_company"], :name => "showon_company"
    add_index "order_groups", ["showon_guild"], :name => "showon_guild"
    add_index "order_plan_renewals", ["order_plan_parent_id"], :name => "order_plan_parent_id"
    add_index "order_plan_renewals", ["order_plan_id"], :name => "order_plan_id"
    add_index "order_plans", ["kind"], :name => "kind"
    add_index "order_plans", ["target_kind"], :name => "target_kind"
    add_index "order_plans", ["order_group_id"], :name => "order_group_id"
    add_index "order_plans", ["is_hidden"], :name => "is_hidden"
    add_index "orders", ["owner_type"], :name => "owner_type"
    add_index "orders", ["owner_id"], :name => "owner_id"
    add_index "orders", ["end_at"], :name => "end_at"
    add_index "orders", ["order_plan_id"], :name => "order_plan_id"
    add_index "orders", ["pay_kind"], :name => "pay_kind"
    add_index "orders", ["pay_type"], :name => "pay_type"
    add_index "organization_authorizations", ["user_id"], :name => "user_id"
    add_index "organization_authorizations", ["organization_id"], :name => "organization_id"
    add_index "organization_authorizations", ["main_area"], :name => "main_area"
    add_index "organization_authorizations", ["sub_area"], :name => "sub_area"
    add_index "organization_authorizations", ["created_at"], :name => "created_at"
    add_index "organization_authorizations", ["kind"], :name => "kind"
    add_index "organization_joint_groups", ["owner_id"], :name => "owner_id"
    add_index "organization_joint_groups", ["is_public_joint"], :name => "is_public_joint"
    add_index "organization_joint_requests", ["organization_joint_group_id"], :name => "organization_joint_group_id"
    add_index "organization_joint_requests", ["organization_id"], :name => "organization_id"
    add_index "organization_joint_requests", ["user_id"], :name => "user_id"
    add_index "organization_joint_requests", ["checked"], :name => "checked"
    add_index "organization_joint_requests", ["created_at"], :name => "created_at"
    add_index "organization_members", ["level"], :name => "level"
    add_index "organization_requests", ["organization_id"], :name => "organization_id"
    add_index "organization_requests", ["user_id"], :name => "user_id"
    add_index "organization_requests", ["kind"], :name => "kind"
    add_index "organization_requests", ["end_at"], :name => "end_at"
    add_index "organizations", ["type"], :name => "type"
    add_index "organizations", ["main_area"], :name => "main_area"
    add_index "organizations", ["sub_area"], :name => "sub_area"
    add_index "organizations", ["kind"], :name => "kind"
    add_index "organizations", ["parent_id"], :name => "parent_id"
    add_index "organizations", ["rgt"], :name => "rgt"
    add_index "organizations", ["is_public"], :name => "is_public"
    add_index "organizations", ["sms_amount"], :name => "sms_amount"
    add_index "organizations", ["end_at"], :name => "end_at"
    add_index "places", ["kind"], :name => "kind"
    add_index "places", ["main_area"], :name => "main_area"
    add_index "places", ["sub_area"], :name => "sub_area"
    add_index "portlet_displays", ["portlet_id"], :name => "portlet_id"
    add_index "portlet_displays", ["module_set_id"], :name => "module_set_id"
    add_index "portlet_displays", ["kind"], :name => "kind"
    add_index "portlets", ["organization_id"], :name => "organization_id"
    add_index "portlets", ["module_set_id"], :name => "module_set_id"
    add_index "portlets", ["kind"], :name => "kind"
    add_index "portlets", ["showon"], :name => "showon"
    add_index "portlets", ["addon_site"], :name => "addon_site"
    add_index "portlets", ["adgroup_id"], :name => "adgroup_id"
    add_index "posts", ["user_id"], :name => "user_id"
    add_index "posts", ["parent_id"], :name => "parent_id"
    add_index "posts", ["rgt"], :name => "rgt"
    add_index "posts", ["report"], :name => "report"
    add_index "simple_captcha_data", ["key"], :name => "key"
    add_index "sitelogs", ["level"], :name => "level"
    add_index "sitelogs", ["organization_id"], :name => "organization_id"
    add_index "sitelogs", ["org_kind"], :name => "org_kind"
    add_index "themes", ["organization_id"], :name => "organization_id"
    add_index "themes", ["user_id"], :name => "user_id"
    add_index "themes", ["kind"], :name => "kind"
    add_index "themes", ["is_public"], :name => "is_public"
    add_index "themes", ["site"], :name => "site"
    add_index "themes", ["parent_id"], :name => "parent_id"
    add_index "themes", ["request_site"], :name => "request_site"
    add_index "upload_folders", ["parent_id"], :name => "parent_id"
    add_index "upload_folders", ["user_id"], :name => "user_id"
    add_index "upload_folders", ["temp_key"], :name => "temp_key"
    add_index "uploads", ["type"], :name => "type"
    add_index "users", ["level"], :name => "level"
    add_index "users", ["email"], :name => "email"
    add_index "vote_ips", ["vote_id"], :name => "vote_id"
  end

  def self.down
    #remove nonuse_column & index
      add_column :order_plans , :parent_id , :integer
    #remove nonuse_column & index
    remove_index "adrands", :name => "ad_id"
    remove_index "adrands", :name => "adgroup_id"
    remove_index "adrands", :name => "organization_id"
    remove_index "ads", :name => "organization_id"
    remove_index "blogs", :name => "type"
    remove_index "blogs", :name => "user_id"
    remove_index "commissions", :name => "owner_type"
    remove_index "commissions", :name => "owner_id"
    remove_index "commissions", :name => "end_at"
    remove_index "commissions", :name => "main"
    remove_index "commissions", :name => "from_id"
    remove_index "commissions", :name => "from_type"
    remove_index "commissions", :name => "sub"
    remove_index "domains", :name => "organization_id"
    remove_index "item_alerms", :name => "owner_id"
    remove_index "item_alerms", :name => "owner_type"
    remove_index "item_alerms", :name => "item_flag_id"
    remove_index "item_partakes", :name => "kind"
    remove_index "item_partakes", :name => "trans"
    remove_index "items", :name => "type"
    remove_index "items", :name => "owner_type"
    remove_index "items", :name => "sale_kind"
    remove_index "items", :name => "unique_number"
    remove_index "items", :name => "lft"
    remove_index "items", :name => "is_org_close"
    remove_index "maps", :name => "owner_type"
    remove_index "maps", :name => "temp_key"
    remove_index "member_lists", :name => "module_set_id"
    remove_index "member_lists", :name => "target_type"
    remove_index "member_lists", :name => "target_id"
    remove_index "member_lists", :name => "showon_portlet"
    remove_index "member_lists", :name => "showon_module"
    remove_index "messages", :name => "status"
    remove_index "messages", :name => "kind"
    remove_index "messages", :name => "created_at"
    remove_index "messages", :name => "from_type"
    remove_index "messages", :name => "level_kind"
    remove_index "mobile_messages", :name => "created_at"
    remove_index "mobile_messages", :name => "status"
    remove_index "mobile_messages", :name => "user_id"
    remove_index "mobile_messages", :name => "message_id"
    remove_index "mobile_messages", :name => "pay_from_org_id"
    remove_index "module_sets", :name => "parent_id"
    remove_index "module_sets", :name => "hidden"
    remove_index "module_sets", :name => "display_column"
    remove_index "module_sets", :name => "addon_site"
    remove_index "order_groups", :name => "showon_user"
    remove_index "order_groups", :name => "showon_personal"
    remove_index "order_groups", :name => "showon_company"
    remove_index "order_groups", :name => "showon_guild"
    remove_index "order_plan_renewals", :name => "order_plan_parent_id"
    remove_index "order_plan_renewals", :name => "order_plan_id"
    remove_index "order_plans", :name => "kind"
    remove_index "order_plans", :name => "target_kind"
    remove_index "order_plans", :name => "order_group_id"
    remove_index "order_plans", :name => "is_hidden"
    remove_index "orders", :name => "owner_type"
    remove_index "orders", :name => "owner_id"
    remove_index "orders", :name => "end_at"
    remove_index "orders", :name => "order_plan_id"
    remove_index "orders", :name => "pay_kind"
    remove_index "orders", :name => "pay_type"
    remove_index "organization_authorizations", :name => "user_id"
    remove_index "organization_authorizations", :name => "organization_id"
    remove_index "organization_authorizations", :name => "main_area"
    remove_index "organization_authorizations", :name => "sub_area"
    remove_index "organization_authorizations", :name => "created_at"
    remove_index "organization_authorizations", :name => "kind"
    remove_index "organization_joint_groups", :name => "owner_id"
    remove_index "organization_joint_groups", :name => "is_public_joint"
    remove_index "organization_joint_requests", :name => "organization_joint_group_id"
    remove_index "organization_joint_requests", :name => "organization_id"
    remove_index "organization_joint_requests", :name => "user_id"
    remove_index "organization_joint_requests", :name => "checked"
    remove_index "organization_joint_requests", :name => "created_at"
    remove_index "organization_members", :name => "level"
    remove_index "organization_requests", :name => "organization_id"
    remove_index "organization_requests", :name => "user_id"
    remove_index "organization_requests", :name => "kind"
    remove_index "organization_requests", :name => "end_at"
    remove_index "organizations", :name => "type"
    remove_index "organizations", :name => "main_area"
    remove_index "organizations", :name => "sub_area"
    remove_index "organizations", :name => "kind"
    remove_index "organizations", :name => "parent_id"
    remove_index "organizations", :name => "rgt"
    remove_index "organizations", :name => "is_public"
    remove_index "organizations", :name => "sms_amount"
    remove_index "organizations", :name => "end_at"
    remove_index "places", :name => "kind"
    remove_index "places", :name => "main_area"
    remove_index "places", :name => "sub_area"
    remove_index "portlet_displays", :name => "portlet_id"
    remove_index "portlet_displays", :name => "module_set_id"
    remove_index "portlet_displays", :name => "kind"
    remove_index "portlets", :name => "organization_id"
    remove_index "portlets", :name => "module_set_id"
    remove_index "portlets", :name => "kind"
    remove_index "portlets", :name => "showon"
    remove_index "portlets", :name => "addon_site"
    remove_index "portlets", :name => "adgroup_id"
    remove_index "posts", :name => "user_id"
    remove_index "posts", :name => "parent_id"
    remove_index "posts", :name => "rgt"
    remove_index "posts", :name => "report"
    remove_index "simple_captcha_data", :name => "key"
    remove_index "sitelogs", :name => "level"
    remove_index "sitelogs", :name => "organization_id"
    remove_index "sitelogs", :name => "org_kind"
    remove_index "themes", :name => "organization_id"
    remove_index "themes", :name => "user_id"
    remove_index "themes", :name => "kind"
    remove_index "themes", :name => "is_public"
    remove_index "themes", :name => "site"
    remove_index "themes", :name => "parent_id"
    remove_index "themes", :name => "request_site"
    remove_index "upload_folders", :name => "parent_id"
    remove_index "upload_folders", :name => "user_id"
    remove_index "upload_folders", :name => "temp_key"
    remove_index "uploads", :name => "type"
    remove_index "users", :name => "level"
    remove_index "users", :name => "email"
    remove_index "vote_ips", :name => "vote_id"
  end
end