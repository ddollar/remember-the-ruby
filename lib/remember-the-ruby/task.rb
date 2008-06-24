module RememberTheRuby
class Task < Entity

  def self.from_element(transport, element)
    task = super
    task["occurrences"] = TaskOccurrence.list_from_elements(transport, element, 'task')
    task["next"] = task["occurrences"].sorted_by(:due).first
    task["tags"] = Tag.list_from_elements(transport, element, 'tags/tag')
    task
  end
  
  def save!(params={})
    hydrate_from do
      @transport.tasks.add(:name => self[:name], :parse => params[:parse])
    end
    # TODO: apply tags
  end
  
end
end