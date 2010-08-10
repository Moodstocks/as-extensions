Array.class_eval do

  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  # Return a random element.
  def pick
    self[Kernel.rand(size)]
  end
  
  # Boolean map: same as map but returns a boolean intersection of the resulting values.
  # Hence, the return type of this is a boolean.
  def bmap(&blk)
    map(&blk).inject{ |s,x| s && x }
  end
  
end
