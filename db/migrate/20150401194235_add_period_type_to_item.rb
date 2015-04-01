class AddPeriodTypeToItem < ActiveRecord::Migration
  def change
    add_column :items, :rent_period_type, :string
  end
end
