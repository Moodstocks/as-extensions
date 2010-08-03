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
  
end
