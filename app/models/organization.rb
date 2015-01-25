class Organization < ActiveRecord::Base
	self.inheritance_column = :foo #for type subclass
  acts_as_nested_set

  has_many :styles
  has_many :organization_post_lists

  TYPE = [
  	["公會", 'Guild'] , 
  	["公司", 'Company'] , 
  	["團隊", 'Personal'] , 
  	["商城", 'Commerce']
  ]

  state_machine :using_style, namespace: 'style' do
  	event :useNew do
      transition all => :new
    end

    event :useOld do
      transition all => :old
    end

    state :new
    state :old
    state nil

    state :old, nil do
      def is_old?
        true
      end
    end
    state all - [:old, nil] do
      def is_old?
        false
      end
    end

  end
end