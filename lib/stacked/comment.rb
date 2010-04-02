module Stacked
  class Comment < Base
    attr_accessor :body,
                  :comment_id,
                  :creation_date,
                  :owner_display_name,
                  :owner_user_id,
                  :post_id,
                  :post_type,
                  :score
                  
    alias_method :created_at, :creation_date
  end
end