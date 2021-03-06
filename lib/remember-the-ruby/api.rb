module RememberTheRuby
class API
  
  def initialize(options={})
    @transport = RPC::Transport.new(
      :key    => 'cb877b5c450d216ce9e563394dff6c07', 
      :secret => '97cbbc48a9b1b54c', 
      :frob   => options[:frob], 
      :token  => options[:token]    
    )
  end
  
  def authorization_url
    self.frob = @transport.auth.get_frob
    @transport.auth.get_authorization_url
  end
  
  def authenticate
    self.token = @transport.auth.get_token
  end
  
  # first-order objects #####################################################
  
  def lists
    @transport.lists.get_list
  end
  
  def settings
    @transport.settings.get_list
  end
  
  def tasks
    @transport.tasks.get_list
  end
  
  # derivative objects ######################################################

  def default_list
    lists.find(settings["defaultlist"])
  end
  
  def tags
    found_tags = EntityList.new(@transport, Tag)
    tasks.each do |task|
      task.tags.each do |tag|
        found = false
        found_tags.each do |found_tag|
          if tag.to_s == found_tag.to_s
            found = true
            break
          end
        end
        found_tags << tag unless found
      end
    end
    found_tags
  end
  
  ## accessors ##############################################################

  def frob
    @transport.frob
  end
  
  def frob=(frob)
    @transport.frob = frob
  end
  
  def token=(token)
    @transport.token = token
  end
  
end
end