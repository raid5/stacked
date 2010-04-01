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

    alias_method :gravatar, :email_hash
    alias_method :id, :user_id
    alias_method :name, :display_name
    alias_method :type, :user_type

    
    class << self
      alias_method :reputation, :all
      
      def newest(options = {})
        parse(request(path + "newest", options))
      end
      
      def oldest(options = {})
        parse(request(path + "oldest", options))
      end
      
      def name(options = {})
        parse(request(path + "name", options))
      end
      
      def filter(filter, options={})
        options.reverse_merge!(:filter => filter)
        parse(request(path, options))
      end
    end
  end
end