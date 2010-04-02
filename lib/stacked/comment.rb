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
  end
end