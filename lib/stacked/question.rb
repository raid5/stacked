module Stacked
  class Question < Base
    # Removed accessors by replacing them with metaclass and singleton methods
    # attr_accessor :accepted_answer_id,
    #               :answer_count,
    #               :answers,
    #               :body,
    #               :bounty_closes_date,
    #               :community_owned,
    #               :creation_date, 
    #               :down_vote_count,
    #               :favorite_count,
    #               :last_activity_date,
    #               :last_edit_date,
    #               :owner_display_name,
    #               :owner_user_id,
    #               :question_id,
    #               :score,
    #               :tags,
    #               :title,
    #               :up_vote_count,
    #               :view_count

    # TODO: Combine this into a "has_many"-esque method when I'm not jetlagged.
    # association :comments
    # association :answers

    # collection :active,
    #            :featured,
    #            :hot,
    #            :month,
    #            :newest,
    #            :unanswered,
    #            :votes,
    #            :week

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

    # alias_method :created_at, :creation_date
    # alias_method :down_votes, :down_vote_count
    # alias_method :favorites, :favorite_count
    # alias_method :favourites, :favorite_count
    # alias_method :id, :question_id
    # alias_method :updated_at, :last_edit_date
    # alias_method :up_votes, :up_vote_count
    # alias_method :user, :owner
    # alias_method :views, :view_count

    class << self
      # alias_method :newest_unanswered, :unanswered

      def search(*args)
        raise Stacked::NotImplemented
      end

      # All unanswered questions.
      def unanswered(options={})
        records(path + "/unanswered", options)
      end

      # API v1.0 moved tags to /questions
      # All questions tagged with the given tags.
      # Accepts tags as either +:tags+ or +:tagged+
      # Must be an Array of tags.
      # def tagged(options={})
      #   options[:tagged] ||= []
      #   options[:tagged] = (options[:tagged] << options[:tags]).join(", ")
      #   records(path + "tagged", options)
      # end
    end

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