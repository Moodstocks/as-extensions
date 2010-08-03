DateTime.class_eval do
  
  alias :to_s_noase :to_s
  # Convert to the standard ASE time string format
  def to_s(format=nil)
    if format.nil? then ActiveSupport::Extension::Time::to_string(self)
    else to_s_noase(format) end
  end
  
  # Get the number of seconds since Epoch
  def to_epoch
    ActiveSupport::Extension::Time::epoch(self)
  end
  
  # Convert to a Time object
  def to_time
    ActiveSupport::Extension::Time::to_time(self)
  end
  
end
