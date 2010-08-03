Object.class_eval do
  def deepcopy
    Marshal.load(Marshal.dump(self))
  end
  def boolean?
    is_a?(TrueClass) || is_a?(FalseClass)
  end
end
