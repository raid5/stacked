module Stacked
  class User < Base
    attr_accessor :about_me,
                  :accept_rate,
                  :age,
                  :answer_count,
                  :creation_date,
                  :display_name,
                  :down_vote_count,
                  :email_hash,
                  :last_access_date,
                  :location,
                  :question_count,
                  :reputation,
                  :up_vote_count,
                  :user_id,
                  :user_type,
                  :view_count,
                  :website_url

    alias_method :type, :user_type
    alias_method :id, :user_id
    
    class << self
      alias_method :reputation, :all
      
      def newest(options = {})
        request(path + "newest", options)
      end
    end
  end
end