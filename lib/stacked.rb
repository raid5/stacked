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
    def autoload(klass)
      super(klass, "stacked/#{klass.to_s.underscore}")
    end
  end
  autoload :Answer
  autoload :Base
  autoload :Badge
  autoload :Comment
  autoload :Posttimeline
  autoload :Question
  autoload :Reputation
  autoload :Tag
  autoload :User
  autoload :Usertimeline

  class NotImplemented < StandardError
    def message
      "The requested action is not available in the API."
    end
  end

end

