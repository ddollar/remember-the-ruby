module RememberTheRuby
class EntityList < Array
  
  attr_accessor :defaults
  
  def initialize(transport, type)
    @transport = transport
    @type      = type
    @defaults  = {}
  end
  
  def new
    entity = @type.new(@transport)
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
    
    matches = EntityList.new(@transport, @type)
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
  
  def self.from_rsp(transport, type, rsp, xpath)
    entity_list = EntityList.new(transport, type)
    rsp.get_elements(xpath).map do |element|
      entity_list << type.from_element(transport, element)
    end
    entity_list
  end

end
end