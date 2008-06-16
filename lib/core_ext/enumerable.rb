module Enumerable
  
  def sorted_by(attribute)
    self.sort_by { |e| e[attribute] }
  end
  
end