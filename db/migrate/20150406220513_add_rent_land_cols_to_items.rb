class AddRentLandColsToItems < ActiveRecord::Migration
  def change
    add_column :items, :land_type,        :string
    add_column :items, :land_area_amount, :decimal, precision: 10, scale: 2
    add_column :items, :land_area_unit,   :string

    add_column :items, :is_usage_field,               :boolean
    add_column :items, :is_usage_home,                :boolean
    add_column :items, :is_usage_processing_factory,  :boolean
    add_column :items, :is_usage_company,             :boolean
    add_column :items, :is_usage_tech_factory,        :boolean
    add_column :items, :is_usage_factory,             :boolean
    add_column :items, :is_usage_warehouse,           :boolean
    add_column :items, :is_usage_ad_banner,           :boolean
    add_column :items, :is_usage_store,               :boolean
  end
end
