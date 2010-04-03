module Stacked
  class Answer < Base
    attr_accessor :accepted,
                  :answer_id,
                  :comments,
                  :community_owned,
                  :creation_date,
                  :down_vote_count,
                  :last_edit_date,
                  :owner_display_name,
                  :owner_user_id,
                  :question_id,
                  :score,
                  :title,
                  :up_vote_count,
                  :view_count

    alias_method :created_at, :creation_date
    alias_method :updated_at, :last_edit_date
    alias_method :id, :answer_id
    
    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end

    def user

    end
  end

end