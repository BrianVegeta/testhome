class Item::RentHomeApartment
	COLUMNS = [
		:main_area, #地址
		:sub_area,	#地址
		:road_name,	#路名
		:pattern_room, #房
  	:pattern_living, #聽
  	:pattern_bath,	#衛
  	:pattern_balcony, #陽台(new)
  	:inner_amount, #市內實際使用坪數
  	:total_floor, #總樓層(new)
  	:current_floor, #出租樓層
  	:direction, #朝向
  	#new
  	:has_device_washer,
  	:has_device_freezer,
  	:has_device_tv,
  	:has_device_air_conditioning,
  	:has_device_water_heater,
  	:has_device_net,
  	:has_device_cable_tv,
  	:has_device_natural_gas,
  	:has_furniture_bed,
  	:has_furniture_wardrobe,
  	:has_furniture_sofa,
  	:has_furniture_desk,
  	:has_furniture_chair,
  	:has_parking,
  	#new end
  	:total_price, #租金 元/月
  	:deposit, #押金(new)
  	#new
  	:rent_include_management,
  	:rent_include_clean,
  	:rent_include_cable,
  	:rent_include_net,
  	:rent_include_water,
  	:rent_include_electric,
  	:rent_include_gas,
  	#new end
  	:management_fees, #管理費
  	:rent_period, #最短租期(new)
  	:allow_moved_date, #可遷入日期 (new)
  	:is_student_allow, #身份要求 (new)
  	:is_office_allow, #身份要求 (new)
  	:is_family_allow, #身份要求 (new)
  	:is_cooking_allow, #可開伙 (new) 
  	:is_pet_allow, #可養寵 (new) 
  	:is_nearby_store, #近便利商店(new)
  	:is_nearby_market, #近市場(new)
  	:is_nearby_mall, #近百貨公司(new)
  	:is_nearby_park, #近公園(new)
  	:is_nearby_school, #近學校(new)
  	:is_nearby_hospital, #近醫療機構(new)
  	:is_nearby_nightmarket, #近夜市(new)
  	#new
  	:nearby_station,
  	:nearby_mrt,
  	:nearby_bus,
  	#new end
  	:name, #廣告標題
  	:descript, #特色描述
  	#照片
	]

  DEPOSIT = {
    '面議' => :face_to_face,
    '一個月押金' => :one_months,
    '二個月押金' => :two_months,
    '三個月押金' => :three_months,
    '其他' => :other
  }

  RENT_PERIOD = {
    '三個月'  => '3_months',
    '半年'    => '6_months',
    '一年'    => '1_years',
    '兩年'    => '2_years',
    '其他'    => :other
  }
  
  def self.permit_params(required_param)
    required_param.permit(
      :main_area,
      :sub_area,
      :road_name,
      # address

      :descript
    )
  end
end