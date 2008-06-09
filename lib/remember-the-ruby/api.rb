module RememberTheRuby
class API
  
  attr_reader :frob, :token
  
  def initialize(options={})
    @frob = options[:frob]
    @token = options[:token]
    initialize_api
  end
  
  def initialize_api
    RPC::Transport.init({:key    => 'cb877b5c450d216ce9e563394dff6c07', 
                         :secret => '97cbbc48a9b1b54c', 
                         :frob   => @frob, 
                         :token  => @token})
  end
  
  def authorization_url
    self.frob = RPC::Auth.get_frob
    RPC::Auth.get_authorization_url
  end
  
  def authenticate
    self.token = RPC::Auth.get_token
  end
  
  def lists
    RPC::Tasks.get_list
  end
  
  def frob=(frob)
    @frob = frob
    initialize_api
  end
  
  def token=(token)
    @token = token
    initialize_api
  end
  
end
end