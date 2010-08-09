IO.class_eval do
  
  # Read from a compressed IO stream
  def gzread
    ActiveSupport::Extension::IO::to_string(self, true)
  end
  
end
