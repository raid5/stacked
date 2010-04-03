module Stacked
  class Reputation < Base
    attr_accessor :negative_rep,
                  :on_date,
                  :positive_rep,
                  :post_id,
                  :post_type,
                  :title
    def score
      positive_rep - negative_rep
    end
  end
end