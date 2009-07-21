class Photo < PaperclipAutosizer

  # Paperclip Method for Photograph Attachment
  has_attached_file :photograph, :styles => { :large => "750x750>",
                                              :thumb => "150x150>" },
                    :processors => [:autosize],
                    :url  => "/images/auto_load/photographs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/auto_load/:attachment/:id/:style/:basename.:extension",
                    :default_url => "/images/auto_load/defaults/default_:style.png"
                    
  validates_attachment_size :photograph, :less_than => 1.megabytes
  validates_attachment_content_type :photograph, :content_type => ['image/jpeg', 'image/png']
  after_photograph_post_process :autosize_attached_files

  

  # Paperclip Method for Micrograph Attachment
  has_attached_file :micrograph, :styles => { :large => "750x750>",
                                              :thumb => "150x150>" },
                    :processors => [:autosize],
                    :url  => "/images/auto_load/micrographs/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/auto_load/:attachment/:id/:style/:basename.:extension",
                    :default_url => "/images/auto_load/defaults/default_:style.png"
                    
  validates_attachment_size :micrograph, :less_than => 1.megabytes
  validates_attachment_content_type :micrograph, :content_type => ['image/jpeg', 'image/png']
  after_micrograph_post_process :autosize_attached_files

  

  
  



end
