class AddColsToItemsForSaleHome < ActiveRecord::Migration
  def change
    add_column :items, :house_age,       :integer
    add_column :items, :house_age_unit,  :string

    add_column :items, :house_total_area_amount,          :decimal, precision: 7, scale: 2
    add_column :items, :house_parking_area_amount,        :decimal, precision: 7, scale: 2
    add_column :items, :house_build_area_amount,          :decimal, precision: 7, scale: 2
    add_column :items, :house_public_area_amount,         :decimal, precision: 7, scale: 2
    add_column :items, :house_additional_area_amount,     :decimal, precision: 7, scale: 2
    add_column :items, :house_land_area_amount,           :decimal, precision: 7, scale: 2
    add_column :items, :house_area_unit,                  :string

    add_column :items, :house_area_include_parking,     :boolean
    add_column :items, :house_price_include_parking,    :boolean
    add_column :items, :house_parking_price,            :decimal, precision: 7, scale: 2

    add_column :items, :house_with_lease, :boolean
    
  end
end
