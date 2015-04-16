class AddItemContact < ActiveRecord::Migration
  def change
    add_column :items, :contact_name,                 :string
    add_column :items, :contact_declaration_disturb,  :boolean
    add_column :items, :contact_mobile,               :string
    add_column :items, :contact_mobile_hidden,        :boolean
    add_column :items, :contact_phone,                :string
    add_column :items, :contact_phone_hidden,         :boolean
    add_column :items, :contact_email,                :string
  end
end
