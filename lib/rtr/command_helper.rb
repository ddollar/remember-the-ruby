$methods = {}

def register_method(method, &blk)
  $methods[method] = blk
end

def usage_and_exit
  puts "usage: rtr <command> [options]"
  exit 1
end
  