module Stacked
  # Stacked::User class.
  class User < Base
    attr_accessor :about_me,
                  :accept_rate,
                  :association_id,
                  :age,
                  :answer_count,
                  :badge_counts,
                  :creation_date,
                  :email_hash,
                  :display_name,
                  :down_vote_count,
                  :email_hash,
                  :last_access_date,
                  :location,
                  :question_count,
                  :reputation,
                  :timed_penalty_date,
                  :up_vote_count,
                  :user_id,
                  :user_answers_url,
                  :user_badges_url,
                  :user_comments_url,
                  :user_favorites_url,
                  :user_mentioned_url,
                  :user_questions_url,
                  :user_reputation_url,
                  :user_tags_url,
                  :user_timeline_url,
                  :user_type,
                  :view_count,
                  :website_url

    class << self
      # All moderators.
      def moderators(options={})
        records(path + "/moderators", options)
      end
    end

    # Answers by this user.
    def answers(options={})
      parse_answers(request(singular(user_id) + "/answers", options))
    end
    
    # Badges awarded to user.
    def badges(options={})
      parse_badges(request(singular(user_id) + "/badges", options))
    end
    
    # Comments by this user.
    def comments(options={})
      parse_comments(request(singular(user_id) + "/comments", options))
    end
    
    # Comments by this user, mentioning another user
    def comments_mentioning_user(other_user_id, options={})
      parse_comments(request(singular(user_id) + "/comments/#{other_user_id}", options))
    end

    # Favorites of this user.
    def favorites(options={})
      parse_questions(request(singular(user_id) + "/favorites", options))
    end
    
    # Comments that are directed at user(s).
    def mentioned(options={})
      parse_comments(request(singular(user_id) + "/mentioned", options))
    end

    # Questions by user(s).
    def questions(options={})
      parse_questions(request(singular(user_id) + "/questions", options))
    end

    # Reputation changes for user(s).
    def rep_changes(options={})
      parse_rep_changes(request(singular(user_id) + "/reputation", options))
    end
    
    # Tags participated in by user(s).
    def tags(options={})
      parse_tags(request(singular(user_id) + "/tags", options))
    end

    # Timeline of actions by user(s).
    def timeline(options={})
      parse_user_timeline(request(singular(user_id) + "/timeline", options))
    end

  end
end