require 'bundler'

Bundler.require(:default, :development)
Bundler.setup

require './lib/cloverly'

require 'rspec/matchers'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
  end
end
