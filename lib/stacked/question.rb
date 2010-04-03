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

    def owner
      @owner ||= User.find(owner_user_id)
    end

    def accepted_answer
      Answer.find(accepted_answer_id) if accepted_answer_id
    end

    alias_method :created_at, :creation_date
    alias_method :down_votes, :down_vote_count
    alias_method :favorites, :favorite_count
    alias_method :favourites, :favorite_count
    alias_method :id, :question_id
    alias_method :updated_at, :last_edit_date
    alias_method :up_votes, :up_vote_count
    alias_method :user, :owner
    alias_method :views, :view_count

    class << self

    end
  end

end