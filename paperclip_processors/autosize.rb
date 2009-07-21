module Paperclip
  class Autosize < Thumbnail
    def initialize file, options = {}, attachment = nil
      super
      attachment.instance.send(:autosizer_attachment_name, attachment.name.to_s)
      attachment.instance.send(:autosizer_original_file_geometry, @current_geometry)
    end
  end
end