module RememberTheRuby
class Task < Entity

  def self.from_element(transport, element)
    task = super
    task["occurrences"] = TaskOccurrence.list_from_rsp(transport, element, 'task')
    task["tags"] = Tag.list_from_rsp(transport, element, 'tags/tag')
    task
  end
  
end
end