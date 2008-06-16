module Enumerable
  
  def path_lookup(path)
    value = self
    parts = path.to_s.split('/')
    parts.each do |part|
      value = hash[part]
    end
    value
  end
  
  def sorted_by(attribute)
    self.sort_by { |e| e.path_lookup(attribute) }
  end
  
end