File.class_eval do
  
  class << self
    # Recursive dirname.
    # dirname(x, 2) <=> dirname(dirname(expand_path(x)))
    def parent_dir(x, n=1, expand=true)
      (n > 1) ? parent_dir(dirname(expand_path(x)), n-1, false) : dirname(x)
    end
  end
  
end
