class AddUserLastLoginAt < ActiveRecord::Migration
  def self.up
    add_column :users , :last_login_at , :datetime , :null => false
    ActiveRecord::Base.connection.execute('UPDATE users SET last_login_at = NOW()');
  end

  def self.down
    remove_column :users , :last_login_at
  end
end
