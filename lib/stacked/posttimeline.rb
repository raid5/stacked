module Stacked
  class Posttimeline < Base
    attr_accessor :action,
                  :action_user_id,
                  :creation_date,
                  :post_id,
                  :timeline_type,
                  :user_id
  end
end