Gem::Specification.new do |s|
  s.name        = 'cloverly'
  s.version     = '0.0.4'
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "Ruby library for interaction with Cloverly API"
  s.description = "Cloverly API powers carbon offsets via an API"
  s.authors     = ["Chris Winslett"]
  s.email       = 'chris@cloverly.com'
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = 'https://cloverly.com'
  s.license     = 'MIT'

  s.add_dependency('nokogiri', '>= 1.6', '< 2.0')
  s.add_dependency('faraday', '~>0.9')

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "byebug"
  s.add_development_dependency "dotenv"
end
