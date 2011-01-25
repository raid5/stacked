require 'httparty'
require 'pathname'

module Stacked
  class Base
    include HTTParty

    delegate :request, :singular, :parse, :to => "self.class"

    class << self
      
      # Return the stats provided by the API.
      def stats
        request(base + "stats")["statistics"].first
      end
      
      # All the first group (depends on pagesize) of records for current class.
      def all(options = {})
        records(path, options)
      end

      # A single record belonging to the current class.
      def find(id, options={})
        records(singular(id), options).first
      end
      
      # All records for a given request path.
      def records(p = path, options = {})
        parse(request(p, options)[resource])
      end

      # Raw Hash of request.
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

      # Defines association methods for things such as comments on questions.
      def association(assoc)
        instance_eval do
          assoc = assoc.to_s
          define_method("#{assoc}=") do |records|
            instance_variable_set("@#{assoc}", records.map { |record| "Stacked::#{assoc.classify}".constantize.new(record) })
          end

          define_method(assoc) { instance_variable_get("@#{assoc}") }
        end
      end

      # The path to the singular resource.
      def singular(id)
        path + '/' + id.to_s
      end

      private

      # The root URL of the API,
      def base
        #"http://api.stackoverflow.com/1.0/"
        Stacked::Client.base_url
      end

      # The key to let us in.
      def key
        Stacked::Client.api_key
      end
      
      # Convert the records into actual objects.
      def parse(records, klass=self)
        records.map { |record| klass.new(record) }
      end

      # The path to this particular part of the API.
      # Example if the class is Stacked::Question:
      #
      # http://api.stackoverflow.com/1.0/questions
      
      def path
        base + resource
      end

      # The Stack Overflow friendly version of the class, pluralized.
      def resource
        self.to_s.demodulize.downcase.pluralize
      end
    end

    # Convert an answers result into a collection of Stacked::Answer objects.
    def parse_answers(result)
      parse_type(result, "answer")
    end

    # Convert a badges result into a collection of Stacked::Badge objects.
    def parse_badges(result)
      parse_type(result, "badge")
    end

    # Convert a comments result into a collection of Stacked::Comment objects.
    def parse_comments(result)
      parse_type(result, "comment")
    end

    # Convert a post timeline result into a collection of Stacked::Posttimeline objects.
    def parse_post_timeline(result)
      parse_type(result, "posttimeline")
    end

    # Convert a questions result into a collection of Stacked::Question objects.
    def parse_questions(result)
      parse_type(result, "question")
    end

    # Convert a reputation result into a collection of Stacked::Reputation objects.
    def parse_rep_changes(result)
      parse_type(result, "repchange")
    end

    # Convert a tags result into a collection of Stacked::Tag objects.
    def parse_tags(result)
      parse_type(result, "tag")
    end
    
    # Convert a user timeline result into a collection of Stacked::Usertimeline objects.
    def parse_user_timeline(result)
      parse_type(result, "usertimeline")
    end
    
    # Converts the specified result into objects of the +type+ class.
    def parse_type(result, type)
      parse(result[type.pluralize], "Stacked::#{type.classify}".constantize)
    end

    public

    # Finds a post based on the +post_type+ and +post_id+
    def post
      "Stacked::#{post_type.classify}".constantize.find(post_id)
    end

    # Creates a new object of the given class based on the attributes passed in.
    def initialize(attributes={})
      # p self
      # p attributes.keys.sort.map { |t| t.to_sym }
      attributes.each do |k, v|
        attr_sym = "#{k}=".to_sym
        self.send(attr_sym, v) if self.respond_to?(attr_sym)
      end
    end
  end
end