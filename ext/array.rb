Array.class_eval do

  alias :first :head
  
  def tail
    self[1..-1]
  end

  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  # Return a random element.
  def pick
    self[Kernel.rand(size)]
  end
  
  # Map a method of members to themselves
  def map_m(sym, *args)
    self.map{ |x| x.send(sym.to_sym, *args) }
  end
  
  # Map a function (ie. Method object) to members
  def map_f(f, *args)
    self.map{ |x| f.call(self, *args) }
  end
  
  # Boolean map: same as map but returns a boolean intersection of the resulting values.
  # Hence, the return type of this is a boolean.
  def bmap(&blk)
    map(&blk).inject{ |s,x| s && x }
  end
  
end
