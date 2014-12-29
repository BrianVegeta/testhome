class ChangeMaxForCommission < ActiveRecord::Migration
  def self.up
    change_column "commissions", "value",:integer,:limit => 2,:null => false
  end

  def self.down
    change_column "commissions", "value",:integer,:limit => 1,:null => false
  end
end
