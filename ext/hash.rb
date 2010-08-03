Hash.class_eval do
  
  # Cast keys to symbols.
  def to_sym
    inject({}) do |h, (k,v)|
      h[k.to_sym] = v
      h
    end
  end
  
end
