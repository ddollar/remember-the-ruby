module RememberTheRuby
module RPC

require 'digest/md5'
require 'net/http'
require 'rexml/document'

class Transport
  
  TRANSPORT_URI = 'http://api.rememberthemilk.com'
  
  def self.init(params)
    @@key    = params[:key]
    @@secret = params[:secret]
    @@frob   = params[:frob]
    @@token  = params[:token]
    
    @@transport_http = build_transport_http
  end
  
  def self.request(method, params={})
    params[:method] = method
    doc = REXML::Document.new(@@transport_http.get(build_rest_path(params)).body)
    doc.elements['rsp']
  end
  
  def self.build_transport_http
    uri = URI::parse(TRANSPORT_URI)
    @@transport_http = Net::HTTP.start(uri.host, uri.port)
  end
  
  def self.build_service_path(service, params)
    params[:frob]       ||= @@frob
    params[:api_key]    ||= @@key
    params[:auth_token] ||= @@token
    
    clear_empty_parameters(params)
    
    params[:api_sig] = sign_parameters(params)
    "/services/#{service}/?#{flatten_parameters(params)}"
  end
  
  def self.clear_empty_parameters(params)
    params.dup.each do |k, v|
      params.delete(k) if v.nil? || v == ''
    end
  end
  
  def self.build_rest_path(params)
    self.build_service_path('rest', params)
  end
  
  def self.build_auth_path(params)
    self.build_service_path('auth', params)
  end

  def self.sign_parameters(params)
    signature  = @@secret
    signature += params.map { |k, v| [k, v].join('') }.sort.join('')
    Digest::MD5.hexdigest(signature)
  end
  
  def self.flatten_parameters(params)
    params.map { |k, v| [k, v].join('=') }.join('&')
  end
  
  def self.hash_from_element(element)
    element.attributes
  end
  
end

class Auth < Transport
  
  def self.get_authorization_url(params={})
    params[:perms] ||= 'delete'
    data = Transport::TRANSPORT_URI + Transport.build_auth_path(params)
  end
  
  def self.get_frob
    rsp = Transport.request('rtm.auth.getFrob')
    rsp.elements['frob'].text
  end
  
  def self.get_token
    rsp = Transport.request('rtm.auth.getToken')
    rsp.elements['auth/token'].text
  end
  
end

class Lists
  
  def self.get_list
    rsp = Transport.request('rtm.lists.getList')
    List.list_from_rsp(rsp, 'lists/list')
  end
  
end

class Tasks
  
  def self.get_list(params={})
    params[:list_id]   ||= nil
    params[:filter]    ||= nil
    params[:last_sync] ||= nil
    rsp = Transport.request('rtm.tasks.getList', params)
    Task.list_from_rsp(rsp, 'tasks/list/taskseries/task')
  end

end

end
end