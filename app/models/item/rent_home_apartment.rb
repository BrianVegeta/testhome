module Item::RentHomeApartment
  extend ActiveSupport::Concern

  included do

    
  end
	
  private
  DEPOSIT_TYPES = {
    '面議'      => :face_to_face,
    '一個月押金' => :one_months,
    '二個月押金' => :two_months,
    '三個月押金' => :three_months,
    '其他'      => :other
  }

  RENT_PERIOD_TYPES = {
    '三個月'   => :three_months,
    '半年'    => :half_year,
    '一年'    => :one_year,
    '兩年'    => :two_years,
    '其他'    => :other
  }

  RENT_PERIOD_UNITS = {
    '年' => :year,
    '月' => :month,
    '日' => :date
  }

  def self.permit_params(required_param)
    required_param.permit(
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,
      :pattern_room, :pattern_living, :pattern_bath, :pattern_balcony,
      :inner_amount, #市內實際使用坪數
      :total_floor, :current_floor,
      :direction, #朝向
      :has_device_washer, :has_device_freezer, :has_device_tv, :has_device_air_conditioning, :has_device_water_heater, :has_device_net, :has_device_cable_tv, :has_device_natural_gas,
      :has_furniture_bed, :has_furniture_wardrobe, :has_furniture_sofa, :has_furniture_desk, :has_furniture_chair,
      :has_parking,
      :total_price, :deposit, :deposit_type, #押金(new)
      :rent_include_management, :rent_include_clean, :rent_include_cable, :rent_include_net, :rent_include_water, :rent_include_electric, :rent_include_gas,
      :management_fees,
      :rent_period_number, :rent_period_unit,
      :allow_moved_date, #可遷入日期 (new)
      :is_student_allow, :is_office_allow, :is_family_allow, 
      :is_cooking_allow, 
      :is_pet_allow,
      :is_nearby_store, :is_nearby_market, :is_nearby_mall, :is_nearby_park, :is_nearby_school, :is_nearby_hospital, :is_nearby_nightmarket,
      :nearby_station_1, :nearby_station_2, :nearby_station_3, 
      :nearby_mrt_1, :nearby_mrt_2, :nearby_mrt_3, 
      :nearby_bus_1, :nearby_bus_2, :nearby_bus_3,
      :name,
      :descript
    )
  end
  
  
end