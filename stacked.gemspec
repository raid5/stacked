require File.expand_path("../lib/stacked/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'stacked'
  s.version     = Stacked::VERSION
  s.authors     = ['Ryan Bigg', 'Adam McDonald']
  s.email       = ['mcdonald.adam@gmail.com']
  s.homepage    = 'http://github.com/raid5/stacked'
  s.summary     = 'Ruby wrapper for the Stackoverflow API'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'rspec', '~> 2.4'
  
  s.add_runtime_dependency 'activesupport', '~> 3.0.3'
  s.add_runtime_dependency 'httparty', '~> 0.7.3'

  s.required_rubygems_version = '>= 1.3.6'
  s.platform                  = Gem::Platform::RUBY
  s.rubyforge_project         = "stacked"
  s.require_path              = 'lib'
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
end