class ModuleFixColumns < ActiveRecord::Migration
  def self.up
    add_column :users , "serial" , :string

    #move 0 & 7 switch (item.land_kind)
    #0123456789-
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = land_kind + 1")
    #-123456789a
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = 0 WHERE land_kind = 7")
    #0123456-89a
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = land_kind - 1 WHERE land_kind > 7")
    #0123456789-
  end

  def self.down
    remove_column :users , "serial"

    #0123456789-
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = land_kind + 1 WHERE land_kind >= 7")
    #0123456-89a
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = 7 WHERE land_kind = 0")
    #-123456789a
    ActiveRecord::Base.connection.execute("UPDATE items SET land_kind = land_kind - 1")
    #0123456789-
  end
end
