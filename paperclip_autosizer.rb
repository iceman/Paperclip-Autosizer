class PaperclipAutosizer < ActiveRecord::Base
  self.abstract_class = true
  
  # Reciever Methods for messages from the autosize processor
  def autosizer_attachment_name(attachment_name)
    @attachment_name = attachment_name
  end
  
  def autosizer_original_file_geometry(geometry_object)
    @original_file_geometry = geometry_object
  end
  

private
  def autosize_attached_files
    styles_to_autosize = get_styles_to_autosize
    return if styles_to_autosize.length == 0
    styles_to_autosize.each_pair do |style, column_for_style|
      target_size = calculate_size_of_reduced_image(style)
      self.method(column_for_style.concat('=').to_sym).call(target_size)
    end
  end
  
  def get_styles_to_autosize
    styles_to_autosize = Hash.new
    styles = self.method(@attachment_name).call.styles.keys
    styles.each do |style|
      column_for_style = [@attachment_name, style.to_s, "size"].join("_")
      styles_to_autosize.merge!({style => column_for_style}) if self.class.column_names.include?(column_for_style)
    end
    return styles_to_autosize
  end
  
  def calculate_size_of_reduced_image(style)
    target_width, target_height = self.method(@attachment_name).call.styles[style][:geometry].split("x").collect{|x| x.to_f}
    width, height = @original_file_geometry.width, @original_file_geometry.height
    original_ratio = width.to_f / height.to_f
    if (original_ratio <= 1 && target_height < height)
      width  = original_ratio * target_height
      height = target_height
    elsif (target_width < width)
      width  = target_width
      height = (1 / original_ratio) * target_width
    end
    return [width.round, height.round].join("x")
  end
end
