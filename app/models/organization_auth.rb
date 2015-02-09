class OrganizationAuth < ActiveRecord::Base
	belongs_to :new_user
	acts_as_nested_set counter_cache: :children_count
  # attr_accessible :organization_id, :parent_id
end