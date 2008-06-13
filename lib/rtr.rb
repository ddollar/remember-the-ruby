# Equivalent to a header guard in C/C++
# Used to prevent the class/module from being loaded more than once
unless defined? RTR

module RTR

  # Utility method used to rquire all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to(fname)
    search_me = File.expand_path(File.join(File.dirname(fname), '**', '*.rb'))
    Dir.glob(search_me).sort.each { |rb| require rb }
  end

end

RTR.require_all_libs_relative_to __FILE__

end  # unless defined?