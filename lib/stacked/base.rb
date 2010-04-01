require 'httparty'
require 'pathname'

module Stacked
  class Base
    include HTTParty
    class << self
      def all(options = {})
        records = request(path, options)
        records.map do |record|
          self.new(record)
        end
      end
      
      def request(p=path, options={})
        get(p, :query => { :key => key }.merge!(options))[resource]
      end
      
      private
      
      def base
        Pathname.new("http://api.stackoverflow.com/0.5/")
      end
      
      def resource
        self.to_s.demodulize.downcase.pluralize
      end
      
      def path
        base + resource
      end
      
      def key
        "knockknock"
      end
    end
    
    def initialize(attributes)
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end
  end
end