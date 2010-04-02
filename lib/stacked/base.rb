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
        self.new(request(singular(id), options)[resource.singularize])
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

      def association(assoc)
        instance_eval do
          assoc = assoc.to_s
          define_method("#{assoc}=") do |records|
            instance_variable_set("@#{assoc}", records.map { |record| "Stacked::#{assoc.classify}".constantize.new(record) })
          end

          define_method(assoc) { instance_variable_get("@#{assoc}") }
        end
      end



      def singular(id)
        path + id.to_s
      end

      private


      def base
        Pathname.new("http://api.stackoverflow.com/0.5/")
      end

      def key
        "knockknock"
      end

      def parse(records, klass=self)
        records.map { |record| klass.new(record) }
      end

      def path
        base + resource
      end

      def resource
        self.to_s.demodulize.downcase.pluralize
      end
    end

    def initialize(attributes)
      # p self
      # p attributes.keys.sort.map { |t| t.to_sym }
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end
  end
end