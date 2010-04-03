module Stacked
  class Comment < Base
    attr_accessor :body,
                  :comment_id,
                  :creation_date,
                  :edit_count,
                  :owner_display_name,
                  :owner_user_id,
                  :post_id,
                  :post_type,
                  :reply_to_user_id,
                  :score

    alias_method :created_at, :creation_date
    alias_method :id, :comment_id
    
    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end
    
    def post
      "Stacked::#{post_type.classify}".constantize.find(post_id)
    end
  end
end