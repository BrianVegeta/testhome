module Item::RentPlace
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_place? do |form|
      form.after_initialize :set_rent_place_default

      form.validates :place_type,       presence: true
      form.validates :land_area_amount, presence: true, 
                                        numericality: { 
                                          greater_than: 0, 
                                          less_than_or_equal_to: 9999999.99
                                        }
      form.validates :land_area_unit,   presence: true
      form.validates :place_capacity,   presence: true, 
                                        numericality: { 
                                          only_integer: true,
                                          greater_than_or_equal_to: 1,
                                          less_than_or_equal_to: 9999999
                                        }
      form.validates :parking_amount,   presence: true, 
                                        numericality: { 
                                          only_integer: true,
                                          greater_than_or_equal_to: 1,
                                          less_than_or_equal_to: 9999
                                        }, 
                                        if: 'parking_amount.present?'
      form.validates :manager_type,     presence: true

      form.validate :place_floor_validate
      form.validate :place_usage_validation

      def place_usage_validation
        usages = Item::RentPlace::USAGES.map {|k, v| k}
        place_usage.each do |usage|
          return errors.add(:place_usage, '格式錯誤。') unless usages.include? usage.to_sym
        end
      end

      def place_floor_validate
        return if current_floor.blank?
        return if ['-1', '+1'].include? current_floor
        return if current_floor.match(/^-?[0-9]+$/)
        errors.add(:current_floor, '格式錯誤。')
      end

    end

    def set_rent_place_default
        
    end

    def is_rent_place?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentPlace'
    end
  end


  
  private

  TYPES = {
    '' =>         '請選擇',
    hotel:        '飯店旅館',
    restaurant:   '餐廳',
    conference:   '會議中心',
    holiday:      '渡假中心',
    coffice:      '咖啡茶館',
    sport:        '運動場地',
    official:     '政府校園',
    outdoor:      '戶外場地',
    motel:        '汽車旅館',
    special:      '特殊場地',
    performance:  '展演中心',
    nightclub:    '夜店',
    other:        '其他'
  }

  USAGES = {
    publication:  '發表會場',
    training:     '會議訓練',
    wedding:      '婚宴尾牙',
    performance:  '展覽表演',
    party:        '派對聚會',
    outdoor:      '戶外活動'
  }

  MANAGER_TYPES = {
    owner: '屋主',
    proxy: '代理人'
  }

  PRICE_TYPES = {
    on_hours:   '依時段計價',
    on_tables:  '依桌數計價',
    on_users:   '依人頭計價'
  }

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,

      :place_type,
      {place_usage: []},
      :land_area_amount,
      :land_area_unit,
      :place_capacity,
      :place_price_type,
      :parking_amount,
      :manager_type,

      :nearby_station_1, :nearby_station_2, :nearby_station_3, 
      :nearby_mrt_1, :nearby_mrt_2, :nearby_mrt_3, 
      :nearby_bus_1, :nearby_bus_2, :nearby_bus_3,

      :current_floor,
      :name,
      :descript,
      photo_ids: []
    )
    
    return params
  end
  
  
end