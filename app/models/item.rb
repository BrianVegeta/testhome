class Item < ActiveRecord::Base
	include Item::RentHome
	include Item::RentSuit
	include Item::RentStudio
	include Item::RentStore
	include Item::RentOffice
	include Item::RentOfficehouse
	include Item::RentFactory
	include Item::RentParking
	include Item::RentLand
	include Item::RentPlace

	self.inheritance_column = :foo #for type subclass

	belongs_to :owner, polymorphic: true
	has_many :upload_and_folders, as: :owner

	serialize :nearby_station
	serialize :nearby_mrt
	serialize :nearby_bus
	serialize :photo_ids
	serialize :addition_rooms
	serialize :place_usage

	#Validates
	validates :main_area,    	presence: true
  validates :sub_area,     	presence: true
  validates :addr_street,  	presence: true
  validates :addr_alley, 		numericality: { only_integer: true }, unless: 'addr_alley.nil?'
  validates :addr_lane, 		numericality: { only_integer: true }, unless: 'addr_lane.nil?'
  validates :addr_no,      	presence: true, numericality: { only_integer: true }

  validates :name, presence: true, length: { in: 6..20 }




  # Callbacks
	after_initialize :set_default

	def set_default
		self.photo_ids 		= [] if self.photo_ids.nil?
		self.place_usage 	= [] if self.place_usage.nil?
	end
	
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

  def type_action_name
  	self.post_type.split('_').first
  end

  def type_first_name
  	self.post_type.split('_')[1]
  end

  def type_last_name
  	self.post_type.split('_')[2]
  end

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
		# '法拍屋' => {
		# 	'住宅' => {
		# 		'公寓' => :forceclosure_home_apartment,
		# 		'電梯大樓' => :forceclosure_home_mansion,
		# 		'別墅' => :forceclosure_home_villa,
		# 		'透天厝' => :forceclosure_home_townhouse
		# 	},
		# 	'套房' => {
		# 		'公寓' => :forceclosure_studio_apartment,
		# 		'電梯大樓' => :forceclosure_studio_mansion,
		# 		'別墅' => :forceclosure_studio_villa,
		# 		'透天厝' => :forceclosure_studio_townhouse	
		# 	},
		# 	'店面' => {
		# 		'公寓' => :forceclosure_store_apartment,
		# 		'電梯大樓' => :forceclosure_store_mansion,
		# 		'別墅' => :forceclosure_store_villa,
		# 		'透天厝' => :forceclosure_store_townhouse
		# 	},
		# 	'辦公' => {
		# 		'公寓' => :forceclosure_office_apartment,
		# 		'電梯大樓' => :forceclosure_office_mansion,
		# 		'別墅' => :forceclosure_office_villa,
		# 		'透天厝' => :forceclosure_office_townhouse
		# 	},
		# 	'住辦' => {
		# 		'公寓' => :forceclosure_officehouse_apartment,
		# 		'電梯大樓' => :forceclosure_officehouse_mansion,
		# 		'別墅' => :forceclosure_officehouse_villa,
		# 		'透天厝' => :forceclosure_officehouse_townhouse		
		# 	},
		# 	'廠房' => :forceclosure_factory,
		# 	'車位' => :forceclosure_parking,
		# 	'土地' => :forceclosure_land
		# }
	}

	TYPE_TO_MATCH = {
		rent_home_apartment: { model: 'Item::RentHome', form: :rent_home },
		rent_home_mansion: {   model: 'Item::RentHome', form: :rent_home },
		rent_home_villa: { 		 model: 'Item::RentHome', form: :rent_home },
		rent_home_townhouse: { model: 'Item::RentHome', form: :rent_home },

		rent_suit_apartment: { model: 'Item::RentSuit', form: :rent_suit },
		rent_suit_mansion: { 	 model: 'Item::RentSuit', form: :rent_suit },
		rent_suit_villa: {     model: 'Item::RentSuit', form: :rent_suit },
		rent_suit_townhouse: { model: 'Item::RentSuit', form: :rent_suit },

		rent_studio_apartment: { model: 'Item::RentStudio', form: :rent_studio },
		rent_studio_mansion: { 	 model: 'Item::RentStudio', form: :rent_studio },
		rent_studio_villa: {     model: 'Item::RentStudio', form: :rent_studio },
		rent_studio_townhouse: { model: 'Item::RentStudio', form: :rent_studio },

		rent_room_apartment: { model: 'Item::RentStudio', form: :rent_studio },
		rent_room_mansion: { 	 model: 'Item::RentStudio', form: :rent_studio },
		rent_room_villa: {     model: 'Item::RentStudio', form: :rent_studio },
		rent_room_townhouse: { model: 'Item::RentStudio', form: :rent_studio },

		rent_store_apartment: { model: 'Item::RentStore', form: :rent_store },
		rent_store_mansion: 	{ model: 'Item::RentStore', form: :rent_store },
		rent_store_villa: 		{ model: 'Item::RentStore', form: :rent_store },
		rent_store_townhouse: { model: 'Item::RentStore', form: :rent_store },

		rent_office_apartment: 	{ model: 'Item::RentOffice', form: :rent_office },
		rent_office_mansion: 		{ model: 'Item::RentOffice', form: :rent_office },
		rent_office_villa: 			{ model: 'Item::RentOffice', form: :rent_office },
		rent_office_townhouse: 	{ model: 'Item::RentOffice', form: :rent_office },

		rent_officehouse_apartment: 	{ model: 'Item::RentOfficehouse', form: :rent_officehouse },
		rent_officehouse_mansion: 		{ model: 'Item::RentOfficehouse', form: :rent_officehouse },
		rent_officehouse_villa: 			{ model: 'Item::RentOfficehouse', form: :rent_officehouse },
		rent_officehouse_townhouse: 	{ model: 'Item::RentOfficehouse', form: :rent_officehouse },

		rent_factory: 	{ model: 'Item::RentFactory', form: :rent_factory },
		rent_parking: 	{ model: 'Item::RentParking', form: :rent_parking },
		rent_land: 			{ model: 'Item::RentLand', form: :rent_land },
		rent_place: 		{ model: 'Item::RentPlace', form: :rent_place },

		sale_home_apartment: 	{ model: 'Item::SaleHome', form: :sale_home },
		sale_home_mansion: 		{ model: 'Item::SaleHome', form: :sale_home },
		sale_home_villa: 			{ model: 'Item::SaleHome', form: :sale_home },
		sale_home_townhouse: 	{ model: 'Item::SaleHome', form: :sale_home },

		sale_home_apartment: 		{ model: 'Item::SaleStudio', form: :sale_studio },
		sale_studio_mansion: 		{ model: 'Item::SaleStudio', form: :sale_studio },
		sale_studio_villa: 			{ model: 'Item::SaleStudio', form: :sale_studio },
		sale_studio_townhouse: 	{ model: 'Item::SaleStudio', form: :sale_studio },

		sale_store_apartment: { model: 'Item::SaleStore', form: :sale_store },
		sale_store_mansion: 	{ model: 'Item::SaleStore', form: :sale_store },
		sale_store_villa: 		{ model: 'Item::SaleStore', form: :sale_store },
		sale_store_townhouse: { model: 'Item::SaleStore', form: :sale_store },

		sale_office_apartment: 	{ model: 'Item::SaleOffice', form: :sale_office },
		sale_office_mansion: 		{ model: 'Item::SaleOffice', form: :sale_office },
		sale_office_villa: 			{ model: 'Item::SaleOffice', form: :sale_office },
		sale_office_townhouse: 	{ model: 'Item::SaleOffice', form: :sale_office },

		sale_officehouse_apartment: { model: 'Item::SaleOfficehouse', form: :sale_officehouse },
		sale_officehouse_mansion: 	{ model: 'Item::SaleOfficehouse', form: :sale_officehouse },
		sale_officehouse_villa: 		{ model: 'Item::SaleOfficehouse', form: :sale_officehouse },
		sale_officehouse_townhouse: { model: 'Item::SaleOfficehouse', form: :sale_officehouse },

		sale_factory: { model: 'Item::SaleFactory', form: :sale_factory },
		sale_parking: { model: 'Item::saleParking', form: :sale_parking },
		sale_land: 		{ model: 'Item::saleLand', 		form: :sale_land },

		transfer_store: { model: 'Item::TransferStore', form: :transfer_store },

		rent_booth: 		{ model: 'Item::RentBooth', 		form: :rent_booth },
		sale_booth: 		{ model: 'Item::SaleBooth', 		form: :sale_booth },
		transfer_booth: { model: 'Item::TransferBooth', form: :transfer_booth }
		
	}

	TYPE_ACTIONS = {
		rent: 		'出租',
		sale: 		'出售',
		transfer: '頂讓'
	}

	TYPE_NAMES = {
		home: 				'整層住家',
		suit: 				'獨立套房',
		studio: 			'分租套房',
		room: 				'雅房',
		store: 				'店面',
		office: 			'辦公',
		officehouse: 	'住辦',
		factory: 			'廠房',
		parking: 			'車位',
		land: 				'土地',
		place: 				'場地',
		apartment: 		'公寓',
		mansion: 			'電梯大樓',
		villa: 				'別墅',
		townhouse: 		'透天厝'
	}


end