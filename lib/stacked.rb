begin
  require 'rubygems'
rescue LoadError
  require 'bundler'
  Bundler.setup!
end

require 'active_support'
begin
  require 'active_support/all'
rescue LoadError
end

# The Stacked module.
module Stacked
  # TODO: Use this coupled with autoload_under when AS 3.0 becomes "stable":
  # extend ActiveSupport::Autoload
  # Will not then need to implement it ourselves.
  # 
  # Implement some AS 3.0 code for automatically determining autoload path.
  # Allows us to do:
  #
  # autoload :Base
  #
  # Instead of:
  #
  # autoload :Base, 'stacked/base'
  class << self
    # Autoload classes
    def autoload(klass)
      super(klass, "stacked/#{klass.to_s.underscore}")
    end
  end
  
  autoload :Client
  autoload :Answer
  autoload :Base
  autoload :Badge
  autoload :Comment
  autoload :PostTimeline
  autoload :Question
  autoload :RepChange
  autoload :Tag
  autoload :User
  autoload :UserTimeline

  # NotImplemented::StandardError class.
  class NotImplemented < StandardError
    # Default message for trying to call all/find on unsupported resources.
    def message
      "The requested action is not available in the API."
    end
  end

end

