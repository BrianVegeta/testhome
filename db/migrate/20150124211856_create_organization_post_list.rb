class CreateOrganizationPostList < ActiveRecord::Migration
  def change
    create_table :organization_post_lists do |t|
    	t.belongs_to 	:organization, 			index: true
    	t.string  		:name
    	t.boolean  		:with_cover, null: false, default: false

    	t.timestamps
    end
  end
end
