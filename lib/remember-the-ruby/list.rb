module RememberTheRuby
class List < Entity

  def tasks
    tasks = RPC::Tasks.get_list(:list_id => self['id'])
    tasks.defaults['list_id'] = self['id']
    tasks
  end
  
end
end