Gem::Specification.new do |s|
  s.name        = 'sagas'
  s.version     = '1.0.0'
  s.date        = '2018-12-21'
  s.summary     = "A Ruby implementation of the Saga design pattern"
  s.description = "A dependency-free library to manage distributed transactions in Ruby"
  s.authors     = ["Victor Yu", "Arjun Lall"]
  s.email       = ["victor.yu.canada@gmail.com"]
  s.files       = ["lib/sagas.rb"]
  s.homepage    = 'http://rubygems.org/gems/sagas'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.4'

  s.add_development_dependency "simplecov"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake", "~> 12.3"
  s.add_development_dependency "rspec", "~> 3.8"
end
