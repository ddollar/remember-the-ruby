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
  
  def find(params)
    matches = EntityList.new(@type)
    self.each do |entity|
      matched = true
      params.each do |key, value|
        unless entity[key] == value
          matched = false
          break
        end
      end
      matches << entity if matched
    end
    matches
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