class FixOrganizationJointGroupForShare < ActiveRecord::Migration
  def self.up
    add_column :organization_joint_groups , :owner_id , :integer #主辦單位
    add_column :organization_joint_groups , :is_public_joint , :boolean , :default => true , :null => false #是否公開給人加入(還需審核)
    create_table "organization_joint_requests", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer "organization_joint_group_id" #申請對象id
      t.integer "organization_id" #申請來源
      t.integer "user_id" #申請的使用者
      t.string  "title" #申請標題
      t.text "body" , :limit => 2000 #申請內文
      t.boolean "checked" , :default => false , :null => false #是否已審核
      t.datetime "created_at"#儲存於
      t.datetime "updated_at"#更新於
    end
  end
  def self.down
    remove_column :organization_joint_groups , :owner_id
    remove_column :organization_joint_groups , :is_public_joint
    drop_table :organization_joint_requests
  end
end