module Item::RentStudio
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_studio? do |form|
      form.after_initialize :set_rent_studio_default

      form.validates :main_area,    presence: true
      form.validates :sub_area,     presence: true
      form.validates :addr_street,  presence: true
      form.validates :addr_no,      presence: true, numericality: { only_integer: true }


      form.validates :inner_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}

      form.validates :total_floor,    presence: true
      form.validates :current_floor,  presence: true

      form.validates :partition_material, length: { maximum: 6 }

      form.validates :total_price,  presence: true, numericality: { greater_than_or_equal_to: 1 }
      form.validates :deposit,      presence: true, numericality: { greater_than_or_equal_to: 1 }, if: 'deposit_type == "other"'

      form.validates :rent_period_type,   presence: true
      form.validates :rent_period_number, presence: true, numericality: { only_integer: true }, if: 'rent_period_type == "other"'
      form.validates :rent_period_unit,   presence: true, if: 'rent_period_type == "other"'

      form.validates :name, presence: true, length: { in: 6..20 }

      (1..10).each do |n|
        eval "
          form.with_options if: 'addition_rooms_exist?(#{n})' do |sub_form|
            sub_form.validates :addition_room_#{n}_usage,          presence: true
            sub_form.validates :addition_room_#{n}_inner_amount,   presence: true, numericality: { only_integer: true }
            sub_form.validates :addition_room_#{n}_current_floor,  presence: true, numericality: { only_integer: true }
            sub_form.validates :addition_room_#{n}_total_price,    presence: true
          end
        "
      end

      form.validate :current_floor_validate

      def addition_rooms_exist?(number)
        !(addition_rooms.nil? || addition_rooms[number].nil?)
      end

      def set_rent_studio_default
        self.is_student_allow = true if self.is_student_allow.nil?
        self.is_office_allow  = true if self.is_office_allow.nil?
        self.is_family_allow  = true if self.is_family_allow.nil?
        self.is_pet_allow     = true if self.is_pet_allow.nil?
        self.is_cooking_allow = true if self.is_cooking_allow.nil?
        self.sexual_require   = :both if self.sexual_require.nil?
        self.has_parking      = false if self.has_parking.nil?

        self.allow_moved_date = Time.now.strftime("%Y-%m-%d") if self.allow_moved_date.nil?
      end

      def current_floor_validate
        return if ['-1', '+1'].include? current_floor
        return if current_floor.match(/^[0-9]+$/)
        errors.add(:current_floor, '格式錯誤。')
      end

      # Addition Rooms
      def self.addition_rooms_vattr(numbers, *cols)
        cols.each do |col|
          numbers.each do |number|
            eval "
              def addition_room_#{number}_#{col}
                addition_room_th = (self.addition_rooms || {})[#{number}]
                return (addition_room_th || {})[:#{col}]
              end
              def addition_room_#{number}_#{col}=(value)
                self.addition_rooms ||= {}
                self.addition_rooms[#{number}] ||= {}
                self.addition_rooms[#{number}][:#{col}] = value
              end
            "
          end
        end

      end
      addition_rooms_vattr (1..10), :usage, :inner_amount, :current_floor, :total_price

    end

    def is_rent_studio?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentStudio'
    end

    def partition_material_types

      # raise Item::RentStudio::MATERIALS.invert[:other].inspect
      return :other if Item::RentStudio::MATERIALS.invert[self.partition_material].nil?
      return Item::RentStudio::MATERIALS.invert[self.partition_material]

    end

    def partition_material_types=(value)
            
    end
  end

  
  private

  MATERIALS = {
    '請選擇'   => '',
    '水泥磚牆' => '水泥磚牆',
    '木板'    => '木板',
    '輕材料'   => '輕材料',
    '其他'    => :other
  }

  ADDITION_ROOM_USAGES = {
    ''      => '請選擇用途',
    :room   => '雅房',
    :studio => '分租套房'
  }

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,
      :pattern_balcony,
      :inner_amount, #市內實際使用坪數
      :total_floor, :current_floor,
      :partition_material_types, :partition_material,
      :has_device_washer, :has_device_freezer, :has_device_tv, :has_device_air_conditioning, :has_device_water_heater, :has_device_net, :has_device_cable_tv, :has_device_natural_gas,
      :has_furniture_bed, :has_furniture_wardrobe, :has_furniture_sofa, :has_furniture_desk, :has_furniture_chair,
      :has_parking,
      :total_price, :deposit, :deposit_type, #押金(new)
      :rent_include_management, :rent_include_clean, :rent_include_cable, :rent_include_net, :rent_include_water, :rent_include_electric, :rent_include_gas,
      :rent_period_type, :rent_period_number, :rent_period_unit,
      :allow_moved_date, #可遷入日期 (new)
      :is_student_allow, :is_office_allow, :is_family_allow, 
      :sexual_require,
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
    (1..10).each do |n|
      params = params.merge(required_param.permit("addition_room_#{n}_usage"))
      params = params.merge(required_param.permit("addition_room_#{n}_inner_amount"))
      params = params.merge(required_param.permit("addition_room_#{n}_current_floor"))
      params = params.merge(required_param.permit("addition_room_#{n}_total_price"))
      
      price_name = "addition_room_#{n}_total_price".to_sym 
      params[price_name] = params[price_name].gsub(',', '') unless params[price_name].nil?
    end
    return params
  end
  
  
end