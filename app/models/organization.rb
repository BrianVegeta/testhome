class Organization < ActiveRecord::Base
	self.inheritance_column = :foo #for type subclass
  acts_as_nested_set
end