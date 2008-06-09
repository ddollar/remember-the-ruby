require 'rubygems'
require 'preferences'

module RememberTheRuby
class Storage < Hash
  
  @@manager = Preferences::Manager.new(:remember_the_ruby)
  
  def self.[]=(key, value)
    @@manager[key] = value
    @@manager.save
  end
  
  def self.[](key)
    @@manager[key]
  end

end
end