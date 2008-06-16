require 'term/ansicolor'

module RTR
class Commands
  
  register_method :tasks do |options|
    
    puts "Oustanding Tasks".white.bold
    puts
    api.default_list.tasks.sorted_by('next/due').reverse.each do |task|

      now = DateTime.now
      
      due = task['next/due']
      due = due.to_date unless due.blank?
      
      diff = due.blank? ? nil : due - now
      
      color = case
        when diff.nil?                          then :white
        when diff.abs < 1 && due.day == now.day then :yellow
        when diff < 0                           then :red
        else                                         :white
      end
      
      title = task.name
      title = title.send(color).bold if color
      
      prefix = " * "
      prefix = prefix.send(color).bold if color
      
      puts prefix + title
    end
  end
  
end
end