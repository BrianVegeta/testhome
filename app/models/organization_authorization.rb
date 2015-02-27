class OrganizationAuthorization < ActiveRecord::Base
	belongs_to :user
  belongs_to :organization
  # has_one :user
end