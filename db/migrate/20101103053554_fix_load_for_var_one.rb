class ModuleSet < ActiveRecord::Base
end
class Portlet < ActiveRecord::Base
end
class FixLoadForVarOne < ActiveRecord::Migration
  def self.up
    ##修正第一版錯誤點
    ModuleSet.delete_all("kind > 100")
    Portlet.all.each do |x| x.update_attribute("kind" , x.kind - 1) if x.kind > 3 ; end ; true
  end

  def self.down
    make_error #can't revert on final
  end
end
