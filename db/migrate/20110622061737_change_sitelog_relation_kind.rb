class ChangeSitelogRelationKind < ActiveRecord::Migration
  def self.up
    rename_column :sitelog_relations , :is_checked , :kind
    change_column :sitelog_relations , :kind , :integer , :limit => 1 , :default => 0 , :null => false

    add_index "sitelog_relations", ["blog_id" , "organization_id"], :name => "sitelog_relations_blog_id_organization_id", :unique => true
  end

  def self.down
    remove_index "sitelog_relations", :name => "sitelog_relations_blog_id_organization_id"
    
    change_column :sitelog_relations , :kind , :boolean , :default => false , :null => false
    rename_column :sitelog_relations , :kind , :is_checked
  end
end
