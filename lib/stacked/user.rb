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

    alias_method :answers, :answer_count
    alias_method :created_at, :creation_date
    alias_method :down_votes, :down_vote_count
    alias_method :gravatar, :email_hash
    alias_method :id, :user_id
    alias_method :name, :display_name
    alias_method :type, :user_type
    alias_method :up_votes, :up_vote_count
    alias_method :views, :view_count


    collection :newest, :oldest, :name

    class << self
      alias_method :reputation, :all

      def filter(filter, options={})
        options.reverse_merge!(:filter => filter)
        records(path, options)
      end
    end

    ############
    # Comments #
    ############

    # This method's a bit funny. http://dev.meta.stackoverflow.com/questions/34747/comments-api-method
    def directed_at(comment_id, options={})
      parse_comments(request(singular(id) + "comments" + comment_id.to_s, options))
    end

    def comments(options={})
      parse_comments(request(singular(id) + "comments", options))
    end

    def comments_by_score(options={})
      parse_comments(request(singular(id) + "comments/score", options))
    end

    alias_method :popular_comments, :comments_by_score

    def recent_comments(options={})
      parse_comments(request(singular(id) + "comments/recent", options))
    end

    ##############
    # Favourites #
    ##############

    # Could probably refactor the repetition of request(singular(id)... out of this.

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

    ##############
    # Reputation #
    ##############

    def reputations(options={})
      parse_reputations(request(singular(id) + "reputation", options))
    end

    ############
    # Mentions #
    ############

    def mentioned(options={})
      parse_comments(request(singular(id) + "mentioned", options))
    end

    alias_method :mentions, :mentioned

    ############
    # Timeline #
    ############

    def timeline(options={})
      parse_user_timeline(request(singular(id) + "timeline", options))
    end


    ########
    # Tags #
    ########

    def tags(options={})
      parse_tags(request(singular(id) + "tags", options))
    end

  end
end