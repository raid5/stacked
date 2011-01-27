require 'rspec'
require 'stacked'

RSpec.configure do |config|
  config.before(:all) do
    Stacked::Client.configure do |config|
      config.api_key = ENV['STACKED_API_KEY']
    end
  end
end