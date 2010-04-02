require 'httparty'
require 'pathname'

module Stacked
  class Base
    include HTTParty
    class << self
      def all(options = {})
        records(path, options)
      end
      
      def find(id, options={})
        self.new(request(path + id.to_s, options)[resource.singularize])
      end
      
      def records(p = path, options = {})
        parse(request(p, options)[resource])
      end
      
      def request(p = path, options = {})
        get(p, :query => { :key => key }.merge!(options))
      end
      
      # Define collection methods, such as newest.
      def collection(*names)
        # Forgive me Matz for I have sinned.
        for name in names
          eval <<-EVAL
            def self.#{name}(options = {})
              records(path + "#{name}", options)
            end
          EVAL
        end
      end
      
      private
      
      def parse(records)
        records.map { |record| self.new(record) }
      end
      
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