$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'stacked'
require 'spec'
require 'spec/autorun'
require 'fakeweb'

Dir["spec/support/**/*.rb"].each { |f| require f }

# Uncomment only for debugging as we only ever want to test against the real API.
# At least, until it becomes stable.
# FakeWeb.allow_net_connect = false

Spec::Runner.configure do |config|

end
