module RTR
class Commands
  
  register_method :tasks do |options|
    pp api_connection.tasks.select do |t|
      t.next.due.to_date && t.next.due.to_date > DateTime.now
    end
  end
  
end
end