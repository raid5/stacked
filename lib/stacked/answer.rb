module Stacked
  class Answer < Base
    # attr_accessor :accepted,
    #               :answer_id,
    #               :body,
    #               :comments,
    #               :community_owned,
    #               :creation_date,
    #               :down_vote_count,
    #               :last_edit_date,
    #               :owner_display_name,
    #               :owner_user_id,
    #               :question_id,
    #               :score,
    #               :title,
    #               :up_vote_count,
    #               :view_count

    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
      def search(*args)
        raise Stacked::NotImplemented
      end
    end
    
    # Comments for the answer.
    def comments(options={})
      parse_comments(request(singular(answer_id) + "/comments", options))
    end
    
    # A Stacked::User object representing the owner of the answer.
    def owner_summary
      @owner ||= User.find(owner_user_id)
    end
   
    # A Stacked::Question object representing the question the answer is in response to.
    def question
      @question ||= Question.find(question_id)
    end

    # alias_method :created_at, :creation_date
    # alias_method :updated_at, :last_edit_date
    # alias_method :id, :answer_id
    # alias_method :up_votes, :up_vote_count
    # alias_method :views, :view_count
    # alias_method :user, :owner
    
    # def metaclass
    #   class << self
    #     self
    #   end
    # end
    #   
    # def define_attributes(hash={})
    #   hash.each_pair { |key, value|
    #     metaclass.send :attr_accessor, key
    #     send "#{key}=".to_sym, value
    #   }
    # end
  end
end