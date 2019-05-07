require 'bundler'

Bundler.require(:default, :development)
Bundler.setup

require './lib/cloverly'

require 'rspec/matchers'

Dotenv.load

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
  end
end
