class RemoveUserCellphoneAndFax < ActiveRecord::Migration
  def self.up
    remove_column "users" , "cell_phone"
    remove_column "users" , "fax"
    remove_column "users" , "introduction"
    remove_column "users" , "signature"
  end

  def self.down
    add_column "users" , "cell_phone" , :string
    add_column "users" , "fax" , :string
    add_column "users" , "introduction" , :text
    add_column "users" , "signature" , :string
  end
end
