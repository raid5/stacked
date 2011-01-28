require 'httparty'

module Stacked
  # Stacked::Base class.
  class Base
    include HTTParty

    delegate :request, :singular, :parse, :to => "self.class"

    class << self
      
      # Return the stats provided by the API.
      def stats
        request(base + "stats")["statistics"].first
      end
      
      # All the of records for current class (depends on pagesize).
      def all(options = {})
        records(path, options)
      end

      # A single (or multiple depending on number of ids) record belonging to the current class.
      def find(*args)
        # Determine ids (single or multiple)
        ids = []
        if args.first.instance_of? Fixnum
          ids << args.first
        elsif args.first.instance_of? Array
          ids.concat(args.first)
        end

        # Options hash supplied? Merge in options
        options = {}
        if args.last.instance_of? Hash
          options.merge!(args.last)
        end
        
        recs = records(path_with_ids(ids), options)
        recs.size == 1 ? recs.first : recs
      end
      
      # All records for a given request path.
      def records(p = path, options = {})
        parse(request(p, options)[resource])
      end

      # Raw Hash of request.
      def request(p = path, options = {})
        get(p, :query => { :key => key }.merge!(options))
      end

      # The path to the singular resource.
      def singular(id)
        path + '/' + id.to_s
      end
      
      # The path to either a singular or multiple resources.
      def path_with_ids(ids)
        path + '/' + ids.join(';')
      end
      
      # Convert a user result into a collection of Stacked::User objects.
      def parse_users(result)
        parse(result['users'], "Stacked::User".constantize)
      end

      private

      # The root URL of the API.
      def base
        Stacked::Client.base_url
      end

      # The api key to let us in.
      def key
        Stacked::Client.api_key
      end
      
      # Convert the records into actual objects.
      def parse(records, klass=self)
        records.map { |record| klass.new(record) }
      end

      # The path to this particular part of the API.
      # Example if the class is Stacked::Question:
      #   http://api.stackoverflow.com/1.0/questions
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

    # Convert a post timeline result into a collection of Stacked::PostTimeline objects.
    def parse_post_timeline(result)
      parse_type(result, "post_timeline")
    end

    # Convert a questions result into a collection of Stacked::Question objects.
    def parse_questions(result)
      parse_type(result, "question")
    end

    # Convert a reputation result into a collection of Stacked::Reputation objects.
    def parse_rep_changes(result)
      parse_type(result, "rep_change")
    end

    # Convert a tags result into a collection of Stacked::Tag objects.
    def parse_tags(result)
      parse_type(result, "tag")
    end
    
    # Convert a user timeline result into a collection of Stacked::Usertimeline objects.
    def parse_user_timeline(result)
      parse_type(result, "user_timeline")
    end
    
    # Converts the specified result into objects of the +type+ class.
    def parse_type(result, type)
      parse(result[type.pluralize], "Stacked::#{type.classify}".constantize)
    end
    
    # Return a metaclass.
    def metaclass
      class << self
        self
      end
    end
    
    # Builds attr_accessor for each attribute found in the reponse.
    def define_attributes(hash={})
      hash.each_pair do |key, value|
        metaclass.send(:attr_accessor, key) unless metaclass.respond_to?("#{key}=".to_sym)
        send "#{key}=".to_sym, value
      end
    end

    public

    # Creates a new object of the given class based on the attributes passed in.
    def initialize(attributes={})
      #self.define_attributes(attributes)
      
      attributes.each do |k, v|
        attr_sym = "#{k}=".to_sym
        self.send(attr_sym, v) if self.respond_to?(attr_sym)
      end
    end
    
    # Finds a post based on the +post_type+ and +post_id+
    def post
      "Stacked::#{post_type.classify}".constantize.find(post_id)
    end
  end
end