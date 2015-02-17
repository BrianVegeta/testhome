class AddConfirmOrganToUsers < ActiveRecord::Migration
  def change
  	add_column    :users, :confirm_organization_id, 		:integer
  end
end
