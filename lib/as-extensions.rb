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
    
    # Require an extension / extensions of a library
    def require_ext(ext, dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join( File.dirname(File.dirname(orig)), 'ext' )
      if ext.is_a? Array
        ext.each do |e| require_ext(e, dir) end
      else
        require File.join(dir, ext)
      end
    end

  end # class << self

  # This loading order (need, logger, log) is necessary to bootstrap need()
  ASE::require_part 'need'
  ASE::need 'logger'
  ASE::require_part 'log'
  
  # Now we can load everything normally
  ASE::need %w{ rubygems active_support fileutils }

end end
