require 'date'
require 'rubygems'
require 'term/ansicolor'

class String
  
  include Term::ANSIColor
  
  def to_date
    begin
      date = DateTime.parse(self)
    rescue
      date = nil
    end
    date
  end
  
  def blank?
    self == ""
  end
  
end