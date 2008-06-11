module RememberTheRuby
class Tag < Entity

  def self.from_element(element)
    tag = super
    tag['name'] = element.text
    tag
  end
  
  def to_s
    self['name']
  end
  
  def tasks
    tasks = RPC::Tasks.get_list(:filter => "tag:#{self["name"]}")
    # TODO: add default tag to the tasks list
    tasks
  end
  
end
end