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
  end
  
end