module ActiveSupport module Extension
  class << self
  
    # Remove nil values in a recursive data structure composed
    # of hashes and arrays.
    def deepcompact(x)
      if x.is_a?(Array)
        x.reject{ |x| x.nil? }.map{ |x| deepcompact(x) }
      elsif x.is_a?(Hash)
        ret = {}
        x.each_pair do |k,v|
          ret[k.to_s] = deepcompact(v) if !v.nil?
        end
        ret
      else
        x
      end
    end
    
  end # class << self
end end
