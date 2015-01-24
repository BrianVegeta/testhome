class Image < ActiveRecord::Base
	has_attached_file :avatar, 
										:styles => { 
											:thumb => "100x100>",
											:small => "200x200>",
											:medium => "500x500>",
											:large => "1000x1000>",
										}, 
										:default_url => "missing.jpg",
										# :processors => [:cropper],
										url: "/assets/splash_images/:id/:style/:basename.:extension",
     								path: ":rails_root/public/assets/splash_images/:id/:style/:basename.:extension"
  
  validates_attachment 	:avatar,
  											:content_type => { 
  												:content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] 
  											}
  
end