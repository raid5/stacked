module Stacked
  class Client
    DEFAULT_OPTIONS = {
      :site => 'stackoverflow.com',
      :version => '1.0'
    }
    
    attr_reader :base_uri
    
    def initialize(opts={})
      opts = DEFAULT_OPTIONS.merge(opts)
      @base_uri = URI.parse("http://api.#{opts[:site]}/#{opts[:version]}/")
    end
  end
end