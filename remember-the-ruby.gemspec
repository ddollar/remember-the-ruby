
spec = Gem::Specification.new do |s|
  
  s.executables = [ 'rtr' ]
  
  s.add_dependency 'rake',           '>= 0.8.1'
  s.add_dependency 'term-ansicolor', '>= 1.0.3'
  s.add_dependency 'preferences',    '>= 0.1.3'
  
  s.name     = "remember-the-ruby"
  s.version  = "0.3.2"
  s.summary  = "A Ruby interface to Remember the Milk"
  s.homepage = "http://peervoice.com/software/remember-the-ruby"
  
  s.author   = "David Dollar"
  s.email    = "ddollar@gmail.com"
  
  s.files    = ["bin/rtr","lib/core_ext","lib/core_ext/datetime.rb","lib/core_ext/enumerable.rb","lib/core_ext/fixnum.rb","lib/core_ext/nil.rb","lib/core_ext/string.rb","lib/remember-the-ruby","lib/remember-the-ruby/api.rb","lib/remember-the-ruby/contact.rb","lib/remember-the-ruby/entity.rb","lib/remember-the-ruby/entity_list.rb","lib/remember-the-ruby/group.rb","lib/remember-the-ruby/list.rb","lib/remember-the-ruby/location.rb","lib/remember-the-ruby/note.rb","lib/remember-the-ruby/rpc.rb","lib/remember-the-ruby/storage.rb","lib/remember-the-ruby/tag.rb","lib/remember-the-ruby/task.rb","lib/remember-the-ruby/task_occurrence.rb","lib/remember-the-ruby.rb","lib/rtr","lib/rtr/api.rb","lib/rtr/command_helper.rb","lib/rtr/commands.rb","lib/rtr.rb"]
  s.platform = Gem::Platform::RUBY
                   
  s.rubyforge_project = "remember-the-ruby"
  s.require_path      = "lib"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README"]
  
end