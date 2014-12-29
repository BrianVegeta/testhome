class ModuleSet < ActiveRecord::Base
end
class Blog < ActiveRecord::Base
end
class TableBlog < Blog
end
class RevertCustomBlog < ActiveRecord::Migration
  def self.up
    TableBlog.delete_all
    ModuleSet.delete_all("kind = 7")
  end

  def self.down
  end
end
