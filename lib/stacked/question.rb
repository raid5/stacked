module Stacked
  class Question < Base
    attr_accessor :accepted_answer_id,
                  :answer_count,
                  :answers,
                  :bounty_closes_date,
                  :community_owned,
                  :creation_date, 
                  :down_vote_count,
                  :favorite_count,
                  :last_activity_date,
                  :last_edit_date,
                  :owner_display_name,
                  :owner_user_id,
                  :question_id,
                  :score,
                  :tags,
                  :title,
                  :up_vote_count,
                  :view_count
    
    # TODO: Combine this into a "has_many"-esque method when I'm not jetlagged.
    association :comments
    association :answers
                  
    collection :active,
               :featured,
               :hot,
               :month,
               :newest,
               :unanswered,
               :votes,
               :week
    
    alias_method :created_at, :creation_date
    alias_method :id, :question_id
    
    def user
      User.find(owner_user_id)
    end

    class << self
      
    end
  end
  
end