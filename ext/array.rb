Array.class_eval do

  # Call ASE::deepcompact(self)
  def deepcompact
    require 'as-extensions'
    ActiveSupport::Extension::deepcompact(self)
  end
  
end
