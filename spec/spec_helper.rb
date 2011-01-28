require 'rspec'
require 'stacked'
require 'support/sorted_by_matcher'
require 'support/within_matcher'

RSpec.configure do |c|
  c.include(SortedByMatcher)
  c.include(WithinMatcher)
  
  c.before(:all) do
    Stacked::Client.configure do |config|
      config.api_key = ENV['STACKED_API_KEY']
    end
  end
end