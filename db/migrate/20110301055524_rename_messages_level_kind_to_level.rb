class RenameMessagesLevelKindToLevel < ActiveRecord::Migration
  def self.up
    rename_column :messages , :level_kind , :level
  end

  def self.down
    rename_column :messages , :level , :level_kind
  end
end
