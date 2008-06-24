require 'rubygems'
require 'preferences'

module RememberTheRuby
class Storage < Preferences::Manager
  
  def initialize
    super(:remember_the_ruby, :autosave => true)
  end

  def set_cache_timeout(key, timeout)
    self[:cache] ||= {}
    self[:cache][key] ||= Time.now + timeout
    self.save
  end

  def cache_timeout_for(key)
    original_reader(:cache) ? original_reader(:cache)[key] : nil
  end
  
  def purge_cache!
    return unless self[:cache].is_a?(Enumerable)
    self[:cache].each do |key, timeout|
      self.delete(key)
    end
    self.delete(:cache)
    self.save
  end
  
  alias_method :original_reader, :[]
  
  def [](key)
    now     = Time.now
    timeout = cache_timeout_for(key) || now
    if timeout < now
      self.delete(key)
      self[:cache].delete(key)
    end
    super
  end
  
end
end