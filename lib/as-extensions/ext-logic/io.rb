module ActiveSupport module Extension module IO
  class << self
    
    # Read from an IO stream that can be compressed
    def to_string(io, gzipped=false)
      if gzipped
        ASE::need 'zlib'
        Zlib::GzipReader.new(io).read
      else
        io.read
      end
    end
    
  end # class << self
end end end
