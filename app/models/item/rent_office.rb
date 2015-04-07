module Item::RentOffice
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_office? do |form|
      form.after_initialize :set_rent_office_default

      form.validates :main_area,    presence: true
      form.validates :sub_area,     presence: true
      form.validates :addr_street,  presence: true
      form.validates :addr_no,      presence: true, numericality: { only_integer: true }

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

      def set_rent_office_default
        self.has_parking      = false if self.has_parking.nil?
      end

      def current_floor_validate
        return if ['-1', '+1'].include? current_floor
        return if current_floor.match(/^[0-9]+$/)
        errors.add(:current_floor, '格式錯誤。')
      end

    end

    def is_rent_office?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentOffice'
    end

  end

  
  private

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,
      :inner_amount, #市內實際使用坪數
      :total_floor, :current_floor,
      :has_parking,
      :total_price, :deposit, :deposit_type, #押金(new)
      :management_fees,
      :rent_period_type, :rent_period_number, :rent_period_unit,
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
    
    return params
  end
  
  
end