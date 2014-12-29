class RebuildLog < ActiveRecord::Migration
=begin
  create_table "logs", :force => true do |t|
    !t.boolean  "checked",                              :default => false, :null => false
    !t.integer  "kind",                 :limit => 1,    :default => 0,     :null => false
    *t.text     "message"
    t.string   "exception_message",    :limit => 2000
    t.text     "exception_trace"
    t.text     "log_request"
    t.text     "log_session"
    t.string   "exception_class_name"
    *t.string   "controller_name"
    *t.string   "action_name"
    *t.datetime "created_at"
    t.datetime "updated_at"
  end
=end
  def self.up
    rename_column :logs , :controller_name , :title
    rename_column :logs , :action_name , :sub_title
    rename_column :logs , :message , :body

    remove_column :logs , :updated_at
    remove_column :logs , :exception_class_name
    remove_column :logs , :exception_message
    remove_column :logs , :exception_trace
    remove_column :logs , :log_request
    remove_column :logs , :log_session

    add_column :logs , :remote_ip , :string
  end

  def self.down
    rename_column :logs , :title , :controller_name
    rename_column :logs , :sub_title , :action_name
    rename_column :logs , :body , :message

    add_column :logs , :updated_at , :datetime
    add_column :logs , :exception_class_name , :string
    add_column :logs , :exception_message , :string,    :limit => 2000
    add_column :logs , :exception_trace , :text
    add_column :logs , :log_request , :text
    add_column :logs , :log_session , :text
    
    remove_column :logs , :remote_ip , :string
  end
end
