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

    collection :newest, :oldest, :name

    class << self
      alias_method :reputation, :all

      def filter(filter, options={})
        options.reverse_merge!(:filter => filter)
        records(path, options)
      end
    end

    ###########
    # Answers #
    ###########
    
    def answers(options={})
      parse_answers(request(singular(id) + "answers", options))
    end
    
    def answers_by_views(options={})
      parse_answers(request(singular(id) + "answers/views", options))
    end
    
    def answers_by_votes(options={})
      parse_answers(request(singular(id) + "answers/votes", options))
    end

    def newest_answers(options={})
      parse_answers(request(singular(id) + "answers/newest", options))
    end

    ############
    # Comments #
    ############
    
    def comments(options={})
      parse_comments(request(singular(id) + "comments", options))
    end

    # This method's a bit funny. http://dev.meta.stackoverflow.com/questions/34747/comments-api-method
    def directed_at(other_user_id, options={})
      parse_comments(request(singular(id) + "comments" + other_user_id.to_s, options))
    end
    
    def directed_at_by_date(other_user_id, options={})
      parse_comments(request(singular(id) + "comments" + other_user_id.to_s + "recent", options))
    end
  
    def directed_at_by_score(other_user_id, options={})
      parse_comments(request(singular(id) + "comments" + other_user_id.to_s + "score", options))
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

    alias_method :favorites_by_views, :popular_favorites
    alias_method :favourites_by_views, :popular_favorites

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

    ###############
    # Other stuff #
    ###############

    def reputations(options={})
      parse_reputations(request(singular(id) + "reputation", options))
    end

    def mentioned(options={})
      parse_comments(request(singular(id) + "mentioned", options))
    end
    
    def badges(options={})
      parse_badges(request(singular(id) + "badges", options))
    end
    
    def tags(options={})
      parse_tags(request(singular(id) + "tags", options))
    end

    alias_method :mentions, :mentioned

    def timeline(options={})
      parse_user_timeline(request(singular(id) + "timeline", options))
    end

    alias_method :created_at, :creation_date
    alias_method :down_votes, :down_vote_count
    alias_method :gravatar, :email_hash
    alias_method :id, :user_id
    alias_method :name, :display_name
    alias_method :recent_answers, :answers
    alias_method :type, :user_type
    alias_method :up_votes, :up_vote_count
    alias_method :views, :view_count


  end
end