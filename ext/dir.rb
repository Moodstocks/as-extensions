Dir.class_eval do
  
  # Iterate over files in directory with a specific extension.
  def each_file(ext, &blk)
    grep(/^[^.].*\.(#{ext})$/).each do |f|
      yield "#{path}/#{f}"
    end
  end
  
end
