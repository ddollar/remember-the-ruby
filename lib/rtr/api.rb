def api
  
  @api ||= begin

    api = RememberTheRuby::API.new(:frob  => $storage[:frob], 
                                   :token => $storage[:token])

    unless $storage[:frob]
      system %{open "#{api.authorization_url}"}
      $storage[:frob] = api.frob
      exit
    end

    unless $storage[:token]
      $storage[:token] = api.authenticate
    end
  
    api

  end
  
end
