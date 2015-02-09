class CreateOrganizationAuths < ActiveRecord::Migration
  def change
    create_table :organization_auths do |t|
    	t.belongs_to 		:organization, 	:null => false,	:index => true
      t.belongs_to    :new_user,      :null => true,  :index => true
    	t.string 				:name
  	  t.integer 			:parent_id, 		:null => true, 	:index => true
      t.integer 			:lft, 					:null => false, :index => true
      t.integer 			:rgt, 					:null => false, :index => true

    	t.timestamps
    end
  end
end
