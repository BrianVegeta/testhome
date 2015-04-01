class Item < ActiveRecord::Base
	include Item::RentHomeApartment

	self.inheritance_column = :foo #for type subclass
	belongs_to :owner, polymorphic: true

	serialize :nearby_station
	serialize :nearby_mrt
	serialize :nearby_bus


	
	def self.nearby_virtual_attr(array_collection, *types)
		
    types.each do |type|
    	array_collection.each do |number|
	      eval "
	        def nearby_#{type}_#{number}
	        	(self.nearby_#{type} || {})[#{number}]
	        end
	        def nearby_#{type}_#{number}=(value)
	        	self.nearby_#{type} ||= {}
	          self.nearby_#{type}[#{number}] = value
	        end
	      "
	    end
    end

  end

  nearby_virtual_attr [1, 2, 3], :station, :mrt, :bus

	DIRECTION = {
		nil => '請選擇',
		0 => '座北朝南',
		1 => '座東朝西',
		2 => '座東朝西',
		3 => '座東南朝西北',
		4 => '座南朝北',
		5 => '座西南朝東北',
		6 => '座西朝東',
		7 => '座西北朝東南',
		8 => '未測量'
	}
	
	CATEGORIES = {
		'出租' => {
			'整層住家' => {
				'公寓' => :rent_home_apartment,
				'電梯大樓' => :rent_home_mansion,
				'別墅' => :rent_home_villa,
				'透天厝' => :rent_home_townhouse
			},
			'獨立套房' => {
				'公寓' => :rent_suit_apartment,
				'電梯大樓' => :rent_suit_mansion,
				'別墅' => :rent_suit_villa,
				'透天厝' => :rent_suit_townhouse	
			},
			'分租套房' => {
				'公寓' => :rent_studio_apartment,
				'電梯大樓' => :rent_studio_mansion,
				'別墅' => :rent_studio_villa,
				'透天厝' => :rent_studio_townhouse	
			},
			'雅房' => {
				'公寓' => :rent_room_apartment,
				'電梯大樓' => :rent_room_mansion,
				'別墅' => :rent_room_villa,
				'透天厝' => :rent_room_townhouse	
			},
			'店面' => {
				'公寓' => :rent_store_apartment,
				'電梯大樓' => :rent_store_mansion,
				'別墅' => :rent_store_villa,
				'透天厝' => :rent_store_townhouse		
			},
			'辦公' => {
				'公寓' => :rent_office_apartment,
				'電梯大樓' => :rent_office_mansion,
				'別墅' => :rent_office_villa,
				'透天厝' => :rent_office_townhouse
			},
			'住辦' => {
				'公寓' => :rent_officehouse_apartment,
				'電梯大樓' => :rent_officehouse_mansion,
				'別墅' => :rent_officehouse_villa,
				'透天厝' => :rent_officehouse_townhouse	
			},
			'廠房' => :rent_factory,
			'車位' => :rent_parking,
			'土地' => :rent_land,
			'場地' => :rent_place
		},
		'出售' => {
			'住宅' => {
				'公寓' => :sale_home_apartment,
				'電梯大樓' => :sale_home_mansion,
				'別墅' => :sale_home_villa,
				'透天厝' => :sale_home_townhouse
			},
			'套房' => {
				'公寓' => :sale_studio_apartment,
				'電梯大樓' => :sale_studio_mansion,
				'別墅' => :sale_studio_villa,
				'透天厝' => :sale_studio_townhouse	
			},
			'店面' => {
				'公寓' => :sale_store_apartment,
				'電梯大樓' => :sale_store_mansion,
				'別墅' => :sale_store_villa,
				'透天厝' => :sale_store_townhouse
			},
			'辦公' => {
				'公寓' => :sale_office_apartment,
				'電梯大樓' => :sale_office_mansion,
				'別墅' => :sale_office_villa,
				'透天厝' => :sale_office_townhouse
			},
			'住辦' => {
				'公寓' => :sale_officehouse_apartment,
				'電梯大樓' => :sale_officehouse_mansion,
				'別墅' => :sale_officehouse_villa,
				'透天厝' => :sale_officehouse_townhouse		
			},
			'廠房' => :sale_factory,
			'車位' => :sale_parking,
			'土地' => :sale_land
		},
		'店面' => {
			'出租' => {
				'公寓' => :rent_store_apartment,
				'電梯大樓' => :rent_store_mansion,
				'別墅' => :rent_store_villa,
				'透天厝' => :rent_store_townhouse
			},
			'出售' => {
				'公寓' => :sale_store_apartment,
				'電梯大樓' => :sale_store_mansion,
				'別墅' => :sale_store_villa,
				'透天厝' => :sale_store_townhouse
			},
			'頂讓' => :transfer_store
		},
		'攤位' => {
			'出租' => :rent_booth,
			'出售' => :sale_booth,
			'頂讓' => :transfer_booth
		},
		'法拍屋' => {
			'住宅' => {
				'公寓' => :forceclosure_home_apartment,
				'電梯大樓' => :forceclosure_home_mansion,
				'別墅' => :forceclosure_home_villa,
				'透天厝' => :forceclosure_home_townhouse
			},
			'套房' => {
				'公寓' => :forceclosure_studio_apartment,
				'電梯大樓' => :forceclosure_studio_mansion,
				'別墅' => :forceclosure_studio_villa,
				'透天厝' => :forceclosure_studio_townhouse	
			},
			'店面' => {
				'公寓' => :forceclosure_store_apartment,
				'電梯大樓' => :forceclosure_store_mansion,
				'別墅' => :forceclosure_store_villa,
				'透天厝' => :forceclosure_store_townhouse
			},
			'辦公' => {
				'公寓' => :forceclosure_office_apartment,
				'電梯大樓' => :forceclosure_office_mansion,
				'別墅' => :forceclosure_office_villa,
				'透天厝' => :forceclosure_office_townhouse
			},
			'住辦' => {
				'公寓' => :forceclosure_officehouse_apartment,
				'電梯大樓' => :forceclosure_officehouse_mansion,
				'別墅' => :forceclosure_officehouse_villa,
				'透天厝' => :forceclosure_officehouse_townhouse		
			},
			'廠房' => :forceclosure_factory,
			'車位' => :forceclosure_parking,
			'土地' => :forceclosure_land
		}
	}
end