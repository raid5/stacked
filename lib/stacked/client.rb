module Stacked
  class Client
    
    class << self
      DEFAULT_OPTIONS = {
        :site => 'stackoverflow.com',
        :version => '1.0',
        :api_key => 'key'
      }
      
      attr_accessor :site
      attr_accessor :version
      attr_accessor :api_key
      attr_reader   :base_url
    
      # def initialize(opts={})
      #   opts = DEFAULT_OPTIONS.merge(opts)
      #   @base_uri = URI.parse("http://api.#{opts[:site]}/#{opts[:version]}/")
      # end
    
      def configure
        yield self
      
        @site     ||= DEFAULT_OPTIONS[:site]
        @version  ||= DEFAULT_OPTIONS[:version]
        @api_key  ||= DEFAULT_OPTIONS[:api_key]
        @base_url ||= "http://api.#{@site}/#{@version}/"
      
        true
      end
    end
    
  end
end