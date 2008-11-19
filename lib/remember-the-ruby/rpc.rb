module RememberTheRuby
module RPC

require 'digest/md5'
require 'net/http'
require 'rexml/document'

class Transport
  
  TRANSPORT_URI = 'http://www.rememberthemilk.com'
  
  attr_accessor :key, :secret, :frob, :token
  
  def initialize(params)
    @key    = params[:key]
    @secret = params[:secret]
    @frob   = params[:frob]
    @token  = params[:token]
    
    @transport_http = build_transport_http
  end
  
  public ####################################################################

  def request(method, params={})
    params[:method] = method

    uri  = URI.encode(rest_path(params))
    data = @transport_http.get(uri)
    doc  = REXML::Document.new(data.body)

    doc.elements['rsp']
  end

  # rpc types ###############################################################
  
  def auth
    @auth ||= Auth.new(self)
  end
  
  def lists
    @lists ||= Lists.new(self)
  end
  
  def settings
    @settings ||= Settings.new(self)
  end
  
  def tasks
    @tasks ||= Tasks.new(self)
  end
  
  def timeline
    Timelines.new(self).create
  end
  
  # private #################################################################
  
  def build_transport_http
    uri = URI::parse(TRANSPORT_URI)
    @transport_http = Net::HTTP.start(uri.host, uri.port)
  end
  
  def clear_empty_parameters(params)
    params.dup.each do |k, v|
      params.delete(k) if v.nil? || v == ''
    end
  end
  
  def auth_path(params)
    self.service_path('auth', params)
  end

  def rest_path(params)
    self.service_path('rest', params)
  end

  def service_path(service, params)
    params[:frob]       ||= @frob
    params[:api_key]    ||= @key
    params[:auth_token] ||= @token
    
    clear_empty_parameters(params)
    
    params[:api_sig] = sign_parameters(params)
    "/services/#{service}/?#{flatten_parameters(params)}"
  end

  def sign_parameters(params)
    signature  = @secret
    signature += params.map { |k, v| [k, v].join('') }.sort.join('')
    Digest::MD5.hexdigest(signature)
  end
  
  def flatten_parameters(params)
    params.map { |k, v| [k, v].join('=') }.join('&')
  end
  
  def hash_from_element(element)
    element.attributes
  end
  
end

class Transported
  
  def initialize(transport)
    @transport = transport
  end
  
end

class Auth < Transported
  
  def get_authorization_url(params={})
    params[:perms] ||= 'delete'
    data = Transport::TRANSPORT_URI + @transport.auth_path(params)
  end
  
  def get_frob
    rsp = @transport.request('rtm.auth.getFrob')
    rsp.elements['frob'].text
  end
  
  def get_token
    rsp = @transport.request('rtm.auth.getToken')
    rsp.elements['auth/token'].text
  end
  
end

class Lists < Transported
  
  def get_list
    rsp = @transport.request('rtm.lists.getList')
    List.list_from_elements(@transport, rsp, 'lists/list')
  end
  
end

class Settings < Transported
  
  def get_list
    rsp = @transport.request('rtm.settings.getList')
    rsp.get_elements('settings').first.inject({}) do |memo, element|
      memo[element.name] = element.text
      memo
    end
  end
  
end

class Tasks < Transported
  
  def add(params={})
    params[:list_id]  ||= nil
    params[:name]     ||= nil
    params[:parse]    ||= nil
    
    params[:timeline] = @transport.timeline
    params[:parse]    = params[:parse] ? 1 : 0
    
    rsp = @transport.request('rtm.tasks.add', params)
    Task.from_element(@transport, rsp.get_elements('list/taskseries').first)
  end
  
  def get_list(params={})
    params[:list_id]   ||= nil
    params[:filter]    ||= nil
    params[:last_sync] ||= nil
    rsp = @transport.request('rtm.tasks.getList', params)
    Task.list_from_elements(@transport, rsp, 'tasks/list/taskseries')
  end

end

class Timelines < Transported
  
  def create(params={})
    rsp = @transport.request('rtm.timelines.create', params)
    rsp.get_elements('timeline').first.text
  end
  
end

end
end