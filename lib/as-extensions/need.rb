module ActiveSupport module Extension
  
  # To store gems already need()ed
  NEEDED = {}
  
  class << self
  
    # Require a gem / gems on the fly.
    # Returns true if the gem was successfuly loaded, false otherwise.
    def need(ext)
      if ext.is_a?(Array)
        ext.each do |e| need(e) end
      else
        return true if NEEDED[ext]
        begin
          require ext
        rescue Exception
          ASE::log("Couldn't load \"#{ext}\".", :error)
          return false
        end
        NEEDED[ext] = true
      end
    end
  
  end # class << self
  
end end
