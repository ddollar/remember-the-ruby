module RememberTheRuby
class Tag < Entity

  def self.from_element(transport, element)
    tag = super
    tag['name'] = element.text
    tag
  end
  
  def to_s
    self['name']
  end
  
  def tasks
    tasks = @transport.tasks.get_list(:filter => "tag:#{self["name"]}")
    # TODO: add default tag to the tasks list
    tasks
  end
  
end
end