module ActiveSupport module Extension
  
  # Initialize logger
  LOGGER = Logger.new(STDERR)
  LOGGER.level = Logger::WARN
  
  class << self
  
    # Print to the logs. Exit if logging a fatal error.
    # Level can be one of: :debug, :info, :warn, :error, :fatal.
    # Returns nil.
    def log(s, level=(:warn))
      LOGGER.send(level, s)
      exit! if level == :fatal
      nil
    end
  
    # Run a block with logging disabled
    def silently
      old_level = LOGGER.level
      LOGGER.level = Logger::FATAL
      ret = yield
      LOGGER.level = old_level
      ret
    end
  
  end # class << self 
  
end end
