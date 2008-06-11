module RememberTheRuby
class Task < Entity

  def self.from_element(element)
    task = super
    task["occurrences"] = TaskOccurrence.list_from_rsp(element, 'task')
    task["tags"] = Tag.list_from_rsp(element, 'tags/tag')
    task
  end
  
end
end