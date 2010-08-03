Object.class_eval do
  
  # Completely clone the object.
  # No reference will be shared with the original.
  def deepcopy
    Marshal.load(Marshal.dump(self))
  end
  
  # Return true if the object is a boolean, false otherwise.
  def boolean?
    is_a?(TrueClass) || is_a?(FalseClass)
  end
  
end
