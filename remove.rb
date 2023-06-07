class Remove
  def self.remove_spec_char(files)
    files.each do |file|
      remove_special_characters(file)
    end
  end

  def self.remove_special_characters(file)
    content = File.read(file)
    content.gsub!(/[,!?.]/, "")
    File.open(file, 'w') { |file_open| file_open.puts content }
  end
end
