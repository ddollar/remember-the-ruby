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
  
  def find(options)

    case options
      when String, Integer then 
        params = { 'id' => options.to_s }
        amount = :one
      when Hash then 
        params = options
        amount = :many
      else 
        params = {}
        amount = :many
    end
    
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
    
    amount == :many ? matches : matches.first
  end
  
  def self.from_rsp(type, rsp, xpath)
    entity_list = EntityList.new(type)
    rsp.get_elements(xpath).map do |element|
      entity_list << type.from_element(element)
    end
    entity_list
  end
  
end
end