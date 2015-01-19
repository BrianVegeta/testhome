class Organization < ActiveRecord::Base
	self.inheritance_column = :foo #for type subclass
  
end