Symbol.class_eval do
  
  # Same as String#classify.
  # Note that this method returns a String, not a symbol.
  def classify
    to_s.classify
  end
  
end
