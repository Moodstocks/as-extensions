String.class_eval do
  
  class << self
    
    # Load a string from a file or a URL.
    def from(file_or_url)
      require 'as-extensions'
      ActiveSupport::Extension::String::from(file_or_url)
    end
    
  end # class << self
  
  alias :camelcase_noase :camelcase
  # Same as camelcase from ActiveSupport
  # but dashes are considered as underscores.
  def camelcase
    underscore.camelcase_noase
  end
  
  alias :dasherize_noase :dasherize
  # Same as underscore from ActiveSupport
  # with dashes instead of underscores.
  def dasherize
    underscore.dasherize_noase
  end
  
  # Helper to convert a raw string to a sane identifier with dashes and ASCII letters.
  # Interpolation is here to force String type, to_s won't always work.
  String.class_eval do
    def sanitize_dashes
      "#{ActiveSupport::Extension::SlugString.new(self).approximate_ascii.to_ascii.normalize.to_s}"
    end
  end
  
end
