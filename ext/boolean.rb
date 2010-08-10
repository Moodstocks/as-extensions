TrueClass.class_eval do
  
  # Return 1
  def to_i
    1
  end
  
end

FalseClass.class_eval do
  
  # Return 0
  def to_i
    0
  end
  
end
