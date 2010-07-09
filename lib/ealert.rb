$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

libraries = %w(date ostruct optparse)
libraries.each { |lib| require lib }

require 'rubygems'

begin
  require 'em-http'
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
  DATABASE  = 'event_alert'
  HOST      = 'localhost'
  PORT      = 27017
  LICENSE   = 'tjefdbrxgpqsj6e69uwfzf2j'
  
  autoload :TwitterFilter,    'ealert/twitter_filter'
  autoload :Parse,            'ealert/parse'
  autoload :Calais,           'ealert/calais'
  autoload :Store,            'ealert/store'
  autoload :Config,           'ealert/config'
  autoload :Options,          'ealert/options'
  autoload :Stream,           'ealert/stream'
end