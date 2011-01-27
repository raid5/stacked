module Stacked
  # Stacked::Question class.
  class Question < Base
    
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

    # The Stacked::User representation of the owner.
    def owner_summary
      @owner ||= User.find(owner_user_id)
    end

    # Helper method for creating Stacked::Tag objects when initializing new Stacked::Question objects.
    def tags=(tags)
      @tags = tags.map { |name| Tag.new(:name => name) }
    end
  end
end