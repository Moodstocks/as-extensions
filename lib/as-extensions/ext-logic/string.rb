module ActiveSupport module Extension module String
  class << self
    
    # Load a string from a file or a URL.
    def from(where)
      where.strip!
      uri = URI.parse(where)
      is_gz = (where.split('.').last == 'gz')
      case uri.scheme
        when nil
          unless File.file?( where = File.expand_path(where) )
            return ASE::log("#{where} is not a file.", :error)
          end
          open(where) do |f| return IO::to_string(f, is_gz) end
        else
          ASE::need 'open-uri'
          uri.open do |f| return IO::to_string(f, is_gz) end
      end # case
    end
    
  end # class << self
end end end
