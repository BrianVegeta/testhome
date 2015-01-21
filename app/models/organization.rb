class Organization < ActiveRecord::Base
	self.inheritance_column = :foo #for type subclass
  acts_as_nested_set

  TYPE = [
  	["公會", 'Guild'] , 
  	["公司", 'Company'] , 
  	["團隊", 'Personal'] , 
  	["商城", 'Commerce']
  ]
end