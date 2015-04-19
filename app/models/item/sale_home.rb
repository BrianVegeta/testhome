module Item::SaleHome
  extend ActiveSupport::Concern

  included do

    with_options if: :is_sale_home? do |form|
      form.after_initialize :set_sale_home_default

      form.validates :pattern_room,     presence: true, 
                                        numericality: { only_integer: true, greater_than_or_equal_to: 1 }
      form.validates :pattern_living,   numericality: { only_integer: true }, unless: 'pattern_living.nil?'
      form.validates :pattern_bath,     numericality: { only_integer: true }, unless: 'pattern_bath.nil?'
      form.validates :pattern_balcony,  numericality: { only_integer: true }, unless: 'pattern_balcony.nil?'

      form.validates :house_age,        presence: true,
                                        numericality: { 
                                          only_integer:             true, 
                                          greater_than_or_equal_to: 1,
                                          less_than_or_equal_to:    1000 }

      form.validates :house_age_unit,   presence: true

      form.validates :house_total_area_amount,      presence: true,
                                                    numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999 }
      form.validates :house_parking_area_amount,    numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999
                                                    }, if: 'house_parking_area_amount.present?'
      form.validates :house_build_area_amount,      numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999
                                                    }, if: 'house_build_area_amount.present?'
      form.validates :house_public_area_amount,     numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999
                                                    }, if: 'house_public_area_amount.present?'
      form.validates :house_additional_area_amount, numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999
                                                    }, if: 'house_additional_area_amount.present?'
      form.validates :house_land_area_amount,       numericality: { 
                                                      greater_than_or_equal_to: 0.001,
                                                      less_than_or_equal_to:    99999
                                                    }, if: 'house_land_area_amount.present?'

      form.validates :house_price_ten_thousand,     presence: true, 
                                                    numericality: { 
                                                      greater_than_or_equal_to: 1,
                                                      less_than_or_equal_to:    99999 }

      form.validates :house_parking_price,          presence: true, 
                                                    numericality: { 
                                                      greater_than_or_equal_to: 1,
                                                      less_than_or_equal_to:    99999 
                                                    }, if: 'house_parking_price.present?'


      form.validates :total_floor,    presence: true
      form.validates :current_floor,  presence: true


      form.validate :current_floor_validate

      def set_sale_home_default

        self.house_with_lease           = false if self.house_with_lease.nil?
        self.house_area_include_parking = true  if self.house_area_include_parking.nil?
      end

      def current_floor_validate
        return if ['-1', '+1'].include? current_floor
        return if current_floor.match(/^-?[0-9]+$/)
        errors.add(:current_floor, '格式錯誤。')
      end
    end

    def is_sale_home?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::SaleHome'
    end
  end

  def house_price_ten_thousand
    self.total_price.to_i / 10000
  end

  def house_price_ten_thousand=(value)
    self.total_price = value.to_i * 10000
  end


  
  private

  AGE_UNITS = {
    year:   '年',
    month:  '月'
  }
  
  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,
      :pattern_room, :pattern_living, :pattern_bath, :pattern_balcony,
      :total_floor, :current_floor,
      :direction, #朝向
      
      :house_age, :house_age_unit,
      :house_total_area_amount, :house_area_unit, :house_area_include_parking,
      :house_parking_area_amount,
      :house_build_area_amount,
      :house_public_area_amount,
      :house_additional_area_amount,
      :house_land_area_amount,

      :house_price_ten_thousand, :house_price_include_parking, :house_parking_price,
      :house_with_lease,
      
      :management_fees,
      
      :is_nearby_store, :is_nearby_market, :is_nearby_mall, :is_nearby_park, :is_nearby_school, :is_nearby_hospital, :is_nearby_nightmarket,
      :nearby_station_1, :nearby_station_2, :nearby_station_3, 
      :nearby_mrt_1, :nearby_mrt_2, :nearby_mrt_3, 
      :nearby_bus_1, :nearby_bus_2, :nearby_bus_3,
      :name,
      :descript,
      photo_ids: []
    )
    # params[:total_price]      = params[:total_price].gsub(',', '')
    params[:management_fees]  = params[:management_fees].gsub(',', '')
    return params
  end
  
  
end