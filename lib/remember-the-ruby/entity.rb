module RememberTheRuby
class Entity < Hash
  
  def initialize(data={})
    self.merge!(data)
  end
  
  def self.from_element(element)
    data = element.attributes.keys.inject({}) do |memo, key|
      memo[key] = element.attributes[key]
      memo
    end
    self.new(data)
  end
  
  def self.list_from_rsp(rsp, element)
    EntityList.from_rsp(self, rsp, element)
  end
  
  def method_missing(method_name)
    self[method_name]
  end
  
  alias_method :regular_reader, :[]
  alias_method :regular_writer, :[]=

  def [](key)
    regular_reader(key.to_s)
  end
  
  def []=(key, value)
    regular_writer(key.to_s, value)
  end
    
end
end