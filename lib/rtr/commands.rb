require 'term/ansicolor'
require 'pp'

module RTR
class Commands
  
  register_method :add do |options|
    tags, task_name = options.partition { |o| o[0..0] == '@' }
    task_name = task_name.join(' ')
    
    task = api.tasks.new

    task["name"] = task_name
    task["tags"] = tags.map { |tag| tag[1..-1] }
    
    task.save!(:parse => true)
    
    $storage.purge_cache!
  end
  
  register_method :tasks do |options|

    plain = options.include?('plain')

    header = "Outstanding Tasks"
    header = header.white.bold unless plain

    puts header
    puts
    
    tasks = $storage[:tasks] || api.default_list.tasks
    
    tasks.sorted_by('name').each do |task|

      now = DateTime.now
      
      due = task['next/due']
      due = due.to_date unless due.blank?
      
      diff = due.blank? ? nil : due - now
      
      color = case
        when plain                              then nil
        when diff.nil?                          then :white
        when diff.abs < 1 && due.day == now.day then :yellow
        when diff < 0                           then :red
        else                                         :white
      end
      
      title = task.name
      title = title.send(color).bold if color
      
      prefix = " *"
      prefix = prefix.send(color).bold if color
      
      suffix = task.tags.map { |t| "@#{t.name}" }.join(' ')
      suffix = suffix.cyan unless plain

      puts "#{prefix} #{title} #{suffix}"
      
    end
    
    $storage[:tasks] = tasks
    $storage.set_cache_timeout(:tasks, 30.minutes)
    
  end
  
  register_method :purge do |options|
    $storage.purge_cache!
  end
  
  
end
end