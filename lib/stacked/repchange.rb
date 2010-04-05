module Stacked
  class Repchange < Base
    attr_accessor :negative_rep,
                  :on_date,
                  :positive_rep,
                  :post_id,
                  :post_type,
                  :title

    # Return the cumulative score of this reputation.
    def score
      positive_rep - negative_rep
    end
  end
end