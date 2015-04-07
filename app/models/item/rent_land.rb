module Item::RentLand
  extend ActiveSupport::Concern

  included do

    with_options if: :is_rent_land? do |form|
      form.after_initialize :set_rent_land_default

      form.validates :main_area,    presence: true
      form.validates :sub_area,     presence: true
      form.validates :addr_street,  presence: true
      form.validates :addr_no,      presence: true, numericality: { only_integer: true }

      form.validates :land_area_amount, presence: true, 
                                        numericality: { 
                                          greater_than: 0, 
                                          less_than_or_equal_to: 9999999.99
                                        }

      form.validates :total_price,  presence: true, numericality: { greater_than_or_equal_to: 1 }
      form.validates :deposit,      presence: true, numericality: { greater_than_or_equal_to: 1 }, if: 'deposit_type == "other"'

      form.validates :rent_period_type,   presence: true
      form.validates :rent_period_number, presence: true, numericality: { only_integer: true }, if: 'rent_period_type == "other"'
      form.validates :rent_period_unit,   presence: true, if: 'rent_period_type == "other"'

      form.validates :name, presence: true, length: { in: 6..20 }


      def set_rent_land_default
        
      end

    end

    def is_rent_land?
      return false if self.post_type.nil?
      Item::TYPE_TO_MATCH[self.post_type.to_sym][:model] == 'Item::RentLand'
    end
  end


  
  private

  AREA_UNITS = {
    plain: '坪',
    square_meter: '平方公尺'
  }

  TYPES = {
    house:    '住宅用地',
    business: '商業用地',
    industry: '工業用地',
    build:    '建地',
    field:    '農地',
    forest:   '林地',
    other:    '其他'
  }

  def self.permit_params(required_param)
    params = required_param.permit(
      :post_type,
      :main_area, :sub_area, :addr_no, :addr_no_is_hidden,
      :land_area_amount, #市內實際使用坪數
      :land_area_unit,
      :land_type,
      :is_usage_field, :is_usage_home, :is_usage_processing_factory, :is_usage_company, :is_usage_tech_factory, :is_usage_factory, :is_usage_warehouse, :is_usage_ad_banner, :is_usage_store,
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