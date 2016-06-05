$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'rspec/its'
require 'webmock/rspec'

require_relative 'support/webmock_stubs'

require 'odds_checker'

RSpec.configure do |config|
  config.order = 'random'
end
