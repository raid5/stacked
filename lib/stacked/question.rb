module Stacked
  # Stacked::Question class.
  class Question < Base
    attr_accessor :accepted_answer_id,
                  :answer_count,
                  :answers,
                  :body,
                  :bounty_amount,
                  :bounty_closes_date,
                  :comments,
                  :community_owned,
                  :closed_date,
                  :closed_reason,
                  :creation_date,
                  :down_vote_count,
                  :favorite_count,
                  :last_activity_date,
                  :last_edit_date,
                  :locked_date,
                  :migrated,
                  :owner,
                  :protected_date,
                  :question_id,
                  :question_answers_url,
                  :question_comments_url,
                  :question_timeline_url,
                  :score,
                  :tags,
                  :title,
                  :up_vote_count,
                  :view_count
    
    class << self
      # All questions matching the search.
      def search(options={})
        parse(request(base + "search", options)[resource])
      end

      # All unanswered questions.
      def unanswered(options={})
        records(path + "/unanswered", options)
      end
    end
    
    # Answers for the question.
    def answers(options={})
      parse_answers(request(singular(question_id) + "/answers", options))
    end
    
    # Comments for the question.
    def comments(options={})
      parse_comments(request(singular(question_id) + "/comments", options))
    end

    # A timeline of the question.
    def timeline(options={})
      parse_post_timeline(request(singular(question_id) + "/timeline", options))
    end
    
    # The Stacked::Answer representing the accepted answer.
    # nil if none accepted
    def accepted_answer
      Answer.find(accepted_answer_id) if accepted_answer_id
    end
    
    # Helper method for creating Stacked::User object when initializing new Stacked::Question objects.
    def owner=(attributes)
      @owner = User.new(attributes)
    end

    # Helper method for creating Stacked::Tag objects when initializing new Stacked::Question objects.
    def tags=(tags)
      @tags = tags.map { |name| Tag.new(:name => name) }
    end
  end
end