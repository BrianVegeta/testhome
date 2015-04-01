class AddColsToItemsForNewForm < ActiveRecord::Migration
  def change

    change_table(:items) do |t|
      t.column :post_state, :string
      t.column :post_type,  :string
      # address
      t.column :addr_street,          :string
      t.column :addr_alley,           :integer
      t.column :addr_lane,            :integer
      t.column :addr_no,              :integer
      t.column :addr_no_is_hidden,    :boolean
      
      #pattern
      t.column :pattern_balcony, :integer

      #floor
      t.column :total_floor,        :integer
      t.column :current_floor,      :integer

      #device
      t.column :has_device_washer,            :boolean
      t.column :has_device_freezer,           :boolean
      t.column :has_device_tv,                :boolean
      t.column :has_device_air_conditioning,  :boolean
      t.column :has_device_water_heater,      :boolean
      t.column :has_device_net,               :boolean
      t.column :has_device_cable_tv,          :boolean
      t.column :has_device_natural_gas,       :boolean
    
      #furniture
      t.column :has_furniture_bed,            :boolean
      t.column :has_furniture_wardrobe,       :boolean
      t.column :has_furniture_sofa,           :boolean
      t.column :has_furniture_desk,           :boolean
      t.column :has_furniture_chair,          :boolean

      t.column :has_parking, :boolean

      t.column :deposit,      :integer
      t.column :deposit_type, :string
    
      #include
      t.column :rent_include_management,  :boolean
      t.column :rent_include_clean,       :boolean
      t.column :rent_include_cable,       :boolean
      t.column :rent_include_net,         :boolean
      t.column :rent_include_water,       :boolean
      t.column :rent_include_electric,    :boolean
      t.column :rent_include_gas,         :boolean
      
      t.column :rent_period_number, :integer
      t.column :rent_period_unit,   :string
      
      t.column :allow_moved_date, :date
      
      #Identity requirement
      t.column :is_student_allow, :boolean
      t.column :is_office_allow,  :boolean
      t.column :is_family_allow,  :boolean

      # action allow
      t.column :is_cooking_allow, :boolean
      t.column :is_pet_allow,     :boolean
      
      # nearby
      t.column :is_nearby_store,        :boolean
      t.column :is_nearby_market,       :boolean
      t.column :is_nearby_mall,         :boolean
      t.column :is_nearby_park,         :boolean
      t.column :is_nearby_school,       :boolean
      t.column :is_nearby_hospital,     :boolean
      t.column :is_nearby_nightmarket,  :boolean
      
      # traffic 
      t.column :nearby_station, :text
      t.column :nearby_mrt,     :text
      t.column :nearby_bus,     :text

      t.column :deleted_at, :timestamp
    end
  end
end
