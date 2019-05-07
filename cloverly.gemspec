Gem::Specification.new do |s|
  s.name        = 'cloverly'
  s.version     = '0.0.1'
  s.date        = '2019-05-07'
  s.summary     = "Ruby library for interaciton with Cloverly API"
  s.description = "Cloverly API powers API offsets via an API"
  s.authors     = ["Chris Winslett"]
  s.email       = 'chris@cloverly.com'
  s.files       = ["lib/cloverly.rb"]
  s.homepage    = 'https://cloverly.com'
  s.license     = 'MIT'

  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "faraday"

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "byebug"
  s.add_development_dependency "dotenv"
end
