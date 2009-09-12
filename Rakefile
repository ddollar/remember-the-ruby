require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "remember-the-ruby"
    gem.summary = %Q{A Ruby interface to Remember the Milk}
    gem.description = %Q{http://peervoice.com/software/remember-the-ruby}
    gem.email = "<ddollar@gmail.com>"
    gem.homepage = "http://github.com/ddollar/remember-the-ruby"
    gem.authors = ["David Dollar"]
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "yard"

    gem.add_dependency 'ddollar-preferences', '>= 0.1.3'
    gem.add_dependency 'term-ansicolor',      '>= 1.0.3'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
