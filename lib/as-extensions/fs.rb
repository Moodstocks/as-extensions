module ActiveSupport module Extension
  
  class << self
  
    # Make sure a directory exists;
    # create it if it is not the case.
    def ensure_dir_exists(dir)
      dir = File.expand_path(dir)
      FileUtils.mkdir_p dir unless File.exist?(dir)
    end
    
    # Return the first file that exists in a list of files
    def select_file(*files)
      files.each do |file|
        if File.exists?(file) then return file end
      end
      return nil
    end
  
  end # class << self 
  
end end
