module Stacked
  # Stacked::PostTimeline class.
  class PostTimeline < Base
    attr_accessor :action,
                  :comment_id,
                  :creation_date,
                  :owner,
                  :post_comments_url,
                  :post_id,
                  :post_revision_url,
                  :post_url,
                  :question_id,
                  :revision_guid,
                  :timeline_type,
                  :user
  end
end