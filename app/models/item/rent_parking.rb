module Item::RentParking
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_parking? do |form|
      form.after_initialize :set_rent_parking_default

      form.validates :main_area,    presence: true
      form.validates :sub_area,     presence: true
      form.validates :addr_street,  presence: true
      form.validates :addr_no,      presence: true, numericality: { only_integer: true }

      form.validates :inner_amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000}

      form.validates :total_price,  presence: true, numericality: { greater_than_or_equal_to: 1 }
      form.validates :deposit,      presence: true, numericality: { greater_than_or_equal_to: 1 }, if: 'deposit_type == "other"'

      form.validates :rent_period_type,   presence: true
      form.validates :rent_period_number, presence: true, numericality: { only_integer: true }, if: 'rent_period_type == "other"'
      form.validates :rent_period_unit,   presence: true, if: 'rent_period_type == "other"'

      form.validates :name, presence: true, length: { in: 6..20 }


      def set_rent_parking_default
        self.parking_cate = :tower if self.parking_cate.nil?
        self.parking_type = :plane if self.parking_type.nil?
      end

    end

    def is_rent_parking?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentParking'
    end
  end


  
  private

  CATES = {
    tower:        '立體塔式',
    outdoor:      '戶外廣場',
    basement:     '室內地下',
    under_bridge: '橋下',
    road_side:    '路邊'
  }

  TYPES = {
    plane:      '平面',
    machinery:  '機械'
  }

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_street, :addr_alley, :addr_lane, :addr_no, :addr_no_is_hidden,
      :inner_amount, #市內實際使用坪數
      :parking_cate,
      :parking_type,
      :total_price, :deposit, :deposit_type, #押金(new)
      :rent_period_type, :rent_period_number, :rent_period_unit,
      :name,
      :descript,
      photo_ids: []
    )
    params[:total_price]      = params[:total_price].gsub(',', '')
    params[:deposit]          = params[:deposit].gsub(',', '')
    
    return params
  end
  
  
end