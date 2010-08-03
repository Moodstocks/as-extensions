module ActiveSupport module Extension
  
  # Ruby Time classes are a mess. This module attempts to restore
  # order by making bold choices.
  # It provides a standard string format and always uses UTC and Epoch.
  module Time

    DATE_FORMAT = "%Y-%m-%dT%H:%M:%S"
  
    class << self
    
      def now(type=nil)
        case type
          when :string; 0.seconds.ago.strftime(DATE_FORMAT)
          else 0.seconds.ago
        end
      end
    
      # Convert various time classes to string
      def to_string(t)
        t.respond_to?(:getutc) ? t.getutc.strftime(DATE_FORMAT) : t.strftime(DATE_FORMAT)
      end
    
      # Convert an ASE time string to a DateTime
      def from_string(s)
        ::Time.parse("#{s}Z")
      end
    
      # Force conversion of a DateTime to a Time
      def to_time(t)
        if t.is_a?(::Time) then t
        else from_string(to_string(t)) end
      end
    
      # Converts various times to a number of seconds since Epoch
      def epoch(t)
        if t.nil? then epoch(now)
        elsif ( t.is_a?(::Time) || t.is_a?(::Numeric) ) then t.to_i
        elsif t.is_a?(::DateTime) then epoch(to_time(t))
        elsif t.is_a?(::String) then epoch(from_string(t))
        else nil end
      end
    
    end # class << self
  
  end # module Time
  
end end
