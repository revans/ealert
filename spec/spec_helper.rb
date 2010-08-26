$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ealert'
require 'spec'
require 'spec/autorun'
require 'webmock/rspec'
require 'simplecov-html'

RSpec.configure do |config|
  config.include WebMock
end