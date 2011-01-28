module Stacked
  # Stacked::RepChange class.
  class RepChange < Base
    attr_accessor :negative_rep,
                  :on_date,
                  :positive_rep,
                  :post_id,
                  :post_type,
                  :title,
                  :user_id
                  
    # Return the cumulative score of this reputation.
    def score
      positive_rep - negative_rep
    end
  end
end