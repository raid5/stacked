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

    ##############
    # Favourites #
    ##############

    def added_favorites(options={})
      parse_questions(request(singular(id) + "favorites/added", options))
    end

    def favorites(options={})
      parse_questions(request(singular(id) + "favorites", options))
    end

    def newest_favorites(options={})
      parse_questions(request(singular(id) + "favorites/newest", options))
    end

    def popular_favorites(options={})
      parse_questions(request(singular(id) + "favorites/views", options))
    end

    alias_method :favorites_by_votes, :popular_favorites
    alias_method :favourites_by_votes, :popular_favorites

    def recent_favorites(options={})
      parse_questions(request(singular(id) + "favorites/recent", options))
    end



    # Silly Americans.
    alias_method :added_favourites, :added_favorites
    alias_method :favourites, :favorites
    alias_method :popular_favourites, :popular_favorites
    alias_method :recent_favourites, :favorites
    alias_method :newest_favourites, :newest_favorites

    #############
    # Questions #
    #############

    def newest_questions(options={})
      parse_questions(request(singular(id) + "questions/newest", options))
    end

    def questions(options={})
      parse_questions(request(singular(id) + "questions", options))
    end

    def questions_by_views(options={})
      parse_questions(request(singular(id) + "questions/views", options))
    end

    def questions_by_votes(options={})
      parse_questions(request(singular(id) + "questions/votes", options))
    end

    alias_method :popular_questions, :questions_by_votes

    def recent_questions(options={})
      parse_questions(request(singular(id) + "questions/recent", options))
    end

    private
      def parse_questions(result)
        parse(result["questions"], Stacked::Question)
      end
  end
end