class Organization < ActiveRecord::Base
	self.inheritance_column = :foo #for type subclass
  acts_as_nested_set :counter_cache => :children_count

  has_many :styles
  has_many :organization_post_lists
  has_many :organization_auths
  has_many :organization_authorizations
  has_many :organization_members
  has_many :items, as: :owner

  TYPE = [
  	["公會", 'Guild'] , 
  	["公司", 'Company'] , 
  	["團隊", 'Personal'] , 
  	["商城", 'Commerce']
  ]

  #callback
  after_update :check_and_set_level

  #state
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

  def is_last_level?
    self.level_count <= 1
  end

  private
    def check_and_set_level
      return unless self.level_count_changed?
      return if self.children.count == 0
      orgin_level_count = self.children.first.level_count + 1
      level_increment = self.level_count - orgin_level_count

      self.descendants.each do |organ|
        organ.level_count = organ.level_count + level_increment
        organ.save
      end
      
    end
end