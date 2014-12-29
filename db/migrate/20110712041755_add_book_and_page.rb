class AddBookAndPage < ActiveRecord::Migration
  def self.up
    create_table "books", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "module_set_id" , :null => false
      t.integer  "cover_id"
      
      t.integer  "position"
      
      t.string   "title" , :null => false
      t.text     "descript" , :limit => 2000 , :null =>  true
      t.integer  "width" , :null => false , :limit => 2 , :default => 384
      t.integer  "height" , :null => false , :limit => 2 , :default => 512
      
      t.integer  "cc" , :limit => 1 , :default => 0 , :null => false #cc認證，預設0為不使用CC
      t.boolean  "hidden" , :default => false , :null => false
      
      t.integer  "start_page" , :default => 1 , :limit => 2 , :null => false
      t.integer  "zoom" , :default => 2 , :limit => 1 , :null => false #0 = 無放大功能 , 1 = 一倍 , 2 =兩倍
      
      ## be option
      #t.boolean "adult_only" , :default => false , :null => false
      #t.boolean  "is_hard_page" , :default => false, :null => false
      #t.boolean  "is_hard_cover" , :default => false, :null => false
		  #CenterSinglePage="false"		- Single page in center
		  #SingleSided="false"				- Single Page Book
		  #RightToLeft="false"				- Book written right to left
		  #VerticalMode="false"			- Vertical flip mode		
      
      t.string   "options" , :default => "--- {}\n\n" , :null => false
      t.integer  "pages_count" , :default => 0 , :null => false
      
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "books", ["module_set_id"], :name => "books_module_set_id"
    add_index "books", ["cover_id"], :name => "books_cover_id"
    
    create_table "pages", :options => 'engine=MyISAM default charset=utf8', :force => true do |t|
      t.integer  "book_id" , :null => false
      
      t.integer  "position" , :default => 0 , :null => false
      
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.string   "file_fingerprint",  :limit => 32
      
      t.datetime "created_at"
    end
    add_index "pages", ["book_id"], :name => "pages_book_id"
  end

  def self.down
    drop_table "books"
    drop_table "pages"
  end
end
