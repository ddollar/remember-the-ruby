require 'rubygems'
require 'preferences'

module RememberTheRuby
class Storage < Preferences::Manager
  
  def initialize
    super(:remember_the_ruby, :autosave => true)
  end

end
end