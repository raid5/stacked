module Stacked
  # I would really *love* to call this UserTimeline but alas, the API fails me.
  class Usertimeline < Base
    attr_accessor :action,
                  :comment_id,
                  :creation_date,
                  :description,
                  :detail,
                  :post_id,
                  :timeline_type

    alias_method :created_at, :creation_date
  end
end