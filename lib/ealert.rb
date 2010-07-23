$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

libraries = %w(date ostruct optparse yaml)
libraries.each { |lib| require lib }
require 'rubygems'

begin
  require 'em-websocket'
  require 'twitter/json_stream'
  require 'yajl'
  require 'calais'
  require 'simplegeo'
  require 'mongo'
rescue LoadError => e
  "Count not load #{e.inspect}"
end


base  = File.expand_path(File.dirname(__FILE__))
require File.join(base, 'ealert/version')


module EAlert
  USER_CONFIG     = File.expand_path("~/.event_stream")
  INTERNAL_CONFIG = File.join(File.expand_path(File.dirname(__FILE__)), 'config/events.yaml')
  
  autoload :TwitterFilter,    'ealert/twitter_filter'
  autoload :Calais,           'ealert/calais'
  autoload :Store,            'ealert/store'
  autoload :Config,           'ealert/config'
  autoload :Options,          'ealert/options'
  autoload :Stream,           'ealert/stream'
  autoload :WebSocketServer,  'ealert/web_socket_server'
end