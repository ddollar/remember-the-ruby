module RememberTheRuby
class Entity < Hash
  
  def initialize(data={})
    self.merge!(data)
  end
  
  def self.from_element(type, element)
    data = element.attributes.keys.inject({}) do |memo, key|
      memo[key] = element.attributes[key]
      memo
    end
    data['data'] = element.text
    type.new(data)
  end
  
  def self.list_from_rsp(rsp, element)
    EntityList.from_rsp(self, rsp, element)
  end
  
end
end