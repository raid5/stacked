module Stacked
  class User < Base
    attr_accessor :about_me,
                  :accept_rate,
                  :age,
                  :answer_count,
                  :creation_date,
                  :display_name,
                  :down_vote_count,
                  :email_hash,
                  :last_access_date,
                  :location,
                  :question_count,
                  :reputation,
                  :up_vote_count,
                  :user_id,
                  :user_type,
                  :view_count,
                  :website_url

    alias_method :gravatar, :email_hash
    alias_method :id, :user_id
    alias_method :name, :display_name
    alias_method :type, :user_type
    alias_method :created_at, :creation_date

    collection :newest, :oldest, :name
    
    delegate :request, :singular, :parse, :to => "self.class"

    class << self
      alias_method :reputation, :all

      def filter(filter, options={})
        options.reverse_merge!(:filter => filter)
        records(path, options)
      end
    end
    
    def questions
      parse_questions(request(singular(id) + "questions"))
    end

    def favorites
      parse_questions(request(singular(id) + "favorites"))
    end

    private
      def parse_questions(result)
        parse(result["questions"], Stacked::Question)
      end

    alias_method :favourites, :favorites # Silly Americans.
  end
end