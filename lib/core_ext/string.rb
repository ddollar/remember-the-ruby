require 'date'

class String
  
  def to_date
    begin
      date = DateTime.parse(self)
    rescue
      date = nil
    end
    date
  end
  
end