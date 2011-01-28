module Stacked
  # Stacked::UserTimeline class.
  class UserTimeline < Base
    attr_accessor :action,
                  :comment_id,
                  :creation_date,
                  :description,
                  :detail,
                  :post_id,
                  :post_type,
                  :timeline_type,
                  :user_id
  end
end