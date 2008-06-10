module RememberTheRuby
class EntityList < Array
  
  attr_accessor :defaults
  
  def initialize(type)
    @type     = type
    @defaults = {}
  end
  
  def new
    entity = @type.new
    @defaults.each do |key, value|
      entity[key] = value
    end
    entity
  end
  
  def self.from_rsp(type, rsp, xpath)
    entity_list = EntityList.new(type)
    rsp.get_elements(xpath).map do |element|
      entity_list << Entity.from_element(type, element)
    end
    entity_list
  end
  
end
end