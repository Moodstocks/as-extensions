Array.class_eval do

  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  def pick
    self[Kernel.rand(size)]
  end
  
end
