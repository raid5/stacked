require 'httparty'
require 'pathname'

module Stacked
  class Base
    include HTTParty

    delegate :request, :singular, :parse, :to => "self.class"

    class << self
      
      def stats
        request(base + "stats")["stats"]
      end
      
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

    def parse_answers(result)
      parse_type(result, "answer")
    end

    def parse_badges(result)
      parse_type(result, "badge")
    end

    def parse_comments(result)
      parse_type(result, "comment")
    end

    def parse_post_timeline(result)
      parse_type(result, "posttimeline")
    end

    def parse_questions(result)
      parse_type(result, "question")
    end

    def parse_reputations(result)
      parse_type(result, "reputation")
    end

    def parse_tags(result)
      parse_type(result, "tag")
    end

    def parse_user_timeline(result)
      parse_type(result, "usertimeline")
    end

    def parse_type(result, type)
      parse(result[type.pluralize], "Stacked::#{type.classify}".constantize)
    end

    public

    def post
      "Stacked::#{post_type.classify}".constantize.find(post_id)
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