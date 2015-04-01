class ChangeItemsPatternDefault < ActiveRecord::Migration
  def up
    change_column_default(:items, :pattern_room,    nil)
    change_column_default(:items, :pattern_living,  nil)
    change_column_default(:items, :pattern_bath,    nil)

    change_column_null(:items, :pattern_room,   true)
    change_column_null(:items, :pattern_living, true)
    change_column_null(:items, :pattern_bath,   true)
    
  end

  def down
    change_column_default(:items, :pattern_room,    0)
    change_column_default(:items, :pattern_living,  0)
    change_column_default(:items, :pattern_bath,    0)

    change_column_null(:items, :pattern_room,   false)
    change_column_null(:items, :pattern_living, false)
    change_column_null(:items, :pattern_bath,   false)

  end
end
