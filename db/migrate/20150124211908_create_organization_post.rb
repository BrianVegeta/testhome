class CreateOrganizationPost < ActiveRecord::Migration
  def change
    create_table :organization_posts do |t|
    	t.belongs_to 	    :organization_post_list, 			index: true
        t.integer           :cover_id
    	t.string 			:title
    	t.text				:description
    	t.text 				:content
    	
    	t.timestamps
    end
  end
end
