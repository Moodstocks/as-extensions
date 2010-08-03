module ActiveSupport module Extension
  
  class Enum
    class << self
    
      def const_missing(key)
        raise NameError "#{key} not in enum" unless @hash.has_key?(key)
        @hash[key]
      end
  
      # Iterate over the key/value pairs in the Enum
      def each_pair(&blk)
        @hash.each_pair(&blk)
      end
    
      def init(h)
        @hash = {}
        h.each_pair do |k,v|
          @hash[k] = v
        end
        self
      end
      
      # Check if a value is part of the Enum
      def include?(x)
        @hash.has_value?(x)
      end
    
    end # class << self 
  end # class Enum
  
  class << self
    
    # Instantiate a new Enum from a Hash.
    # Usage example:
    #   Numbers = enum( :ONE => 1, :TWO => 2, :THREE => 3 )
    #   assert (1 == Numbers::ONE)
    def enum(hash)
      k = Class.new(Enum)
      k.init(hash)
    end
    
  end # class << self
  
end end
