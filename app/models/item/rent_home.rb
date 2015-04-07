module Item::RentHome
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_home? do |form|
      form.after_initialize :set_rent_home_default

      form.validates :main_area,    presence: true
      form.validates :sub_area,     presence: true
      form.validates :addr_street,  presence: true
      form.validates :addr_no,      presence: true, numericality: { only_integer: true }

      form.validates :pattern_room,     presence: true, 
                                        numericality: { only_integer: true, greater_than_or_equal_to: 1 }
      form.validates :pattern_living,   numericality: { only_integer: true }, unless: 'pattern_living.nil?'
      form.validates :pattern_bath,     numericality: { only_integer: true }, unless: 'pattern_bath.nil?'
      form.validates :pattern_balcony,  numericality: { only_integer: true }, unless: 'pattern_balcony.nil?'

      form.validates :inner_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}

      form.validates :total_floor,    presence: true
      form.validates :current_floor,  presence: true

      form.validates :total_price,  presence: true, numericality: { greater_than_or_equal_to: 1 }
      form.validates :deposit,      presence: true, numericality: { greater_than_or_equal_to: 1 }, if: 'deposit_type == "other"'

      form.validates :rent_period_type,   presence: true
      form.validates :rent_period_number, presence: true, numericality: { only_integer: true }, if: 'rent_period_type == "other"'
      form.validates :rent_period_unit,   presence: true, if: 'rent_period_type == "other"'

      form.validates :name, presence: true, length: { in: 6..20 }


      form.validate :current_floor_validate

      def set_rent_home_default
        self.is_student_allow = true if self.is_student_allow.nil?
        self.is_office_allow  = true if self.is_office_allow.nil?
        self.is_family_allow  = true if self.is_family_allow.nil?
        self.is_pet_allow     = true if self.is_pet_allow.nil?
        self.is_cooking_allow = true if self.is_cooking_allow.nil?
        self.has_parking      = false if self.has_parking.nil?

        self.allow_moved_date = Time.now.strftime("%Y-%m-%d") if self.allow_moved_date.nil?
      end

      def current_floor_validate
        return if ['-1', '+1'].include? current_floor
        return if current_floor.match(/^[0-9]+$/)
        errors.add(:current_floor, '格式錯誤。')
      end
    end

    def is_rent_home?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentHome'
    end
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
    '三個月'   => '3_month',
    '半年'    => '6_month',
    '一年'    => '1_year',
    '兩年'    => '2_year',
    '其他'    => :other
  }

  RENT_PERIOD_UNITS = {
    '年' => :year,
    '月' => :month,
    '日' => :date
  }

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
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
      :rent_period_type, :rent_period_number, :rent_period_unit,
      :allow_moved_date, #可遷入日期 (new)
      :is_student_allow, :is_office_allow, :is_family_allow, 
      :is_cooking_allow, 
      :is_pet_allow,
      :is_nearby_store, :is_nearby_market, :is_nearby_mall, :is_nearby_park, :is_nearby_school, :is_nearby_hospital, :is_nearby_nightmarket,
      :nearby_station_1, :nearby_station_2, :nearby_station_3, 
      :nearby_mrt_1, :nearby_mrt_2, :nearby_mrt_3, 
      :nearby_bus_1, :nearby_bus_2, :nearby_bus_3,
      :name,
      :descript,
      photo_ids: []
    )
    params[:total_price]      = params[:total_price].gsub(',', '')
    params[:deposit]          = params[:deposit].gsub(',', '')
    params[:management_fees]  = params[:management_fees].gsub(',', '')
    return params
  end
  
  
end