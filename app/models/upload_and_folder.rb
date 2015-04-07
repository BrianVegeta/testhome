class UploadAndFolder < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :owner, polymorphic: true

  has_attached_file :file, 
                    :styles => { 
                      :thumb => "80x80>",
                      :cover => "180x180>",
                      :view => "360x360>",
                      :public => "640x640>"
                    }, 
                    :convert_options => {
                      :cover => "-background white -gravity center -extent 180x180"
                    },
                    default_url: "http://images.591.com.tw/index/build/no_logo.gif",
                    # :processors => [:cropper],
                    url: "/uploads/:year_month/:style/:id_:fingerprint.:extension",
                    path: ":rails_root/public/uploads/:year_month/:style/:id_:fingerprint.:extension"

  validates_attachment  :file,
                        :content_type => { 
                          :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] 
                        }

  Paperclip.interpolates :year_month do |attachment, style|
    attachment.instance.created_at.strftime('%Y/%m')
  end

end