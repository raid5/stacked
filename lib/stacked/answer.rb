module Stacked
  # Stacked::Answer class.
  class Answer < Base
    attr_accessor :accepted,
                  :answer_comments_url,
                  :answer_id,
                  :body,
                  :comments,
                  :community_owned,
                  :creation_date,
                  :down_vote_count,
                  :last_activity_date,
                  :last_edit_date,
                  :locked_date,
                  :owner,
                  :question_id,
                  :score,
                  :title,
                  :up_vote_count,
                  :view_count
    
    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end
    
    # Comments for the answer.
    def comments(options={})
      parse_comments(request(singular(answer_id) + "/comments", options))
    end
    
    # Helper method for creating Stacked::User object when initializing new Stacked::Answer objects.
    def owner=(attributes)
      @owner = User.new(attributes)
    end
   
    # A Stacked::Question object representing the question the answer is in response to.
    def question
      @question ||= Question.find(question_id)
    end
  end
end