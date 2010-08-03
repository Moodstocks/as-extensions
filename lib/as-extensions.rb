require 'rubygems'
require 'active_support'

module ActiveSupport module Extension
  
  ASE = self
  
  class << self
    
    # Require a part / parts of a library
    def require_part(part, dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join( File.dirname(orig), File.basename(orig, ".rb") )
      if part.is_a? Array
        part.each do |p| require_part(p, dir) end
      else
        require File.join(dir, part)
      end
    end

  end # class << self

  ASE::require_part %w{ log need }

end end
