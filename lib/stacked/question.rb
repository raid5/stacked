module Stacked
  class Question < Base
    attr_accessor :accepted_answer_id, 
                  :answer_count,
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
                  
    collection :active,
               :featured,
               :hot,
               :month,
               :newest,
               :unanswered,
               :votes,
               :week

    class << self
      
      def newest(options = {})
        parse(request(path + "newest", options))
      end
    end
  end
  
end