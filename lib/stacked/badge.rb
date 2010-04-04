module Stacked
  class Badge < Base
    attr_accessor :award_count,
                  :badge_id,
                  :class,
                  :description,
                  :name
                  
    collection :tags
    
    alias_method :id, :badge_id
    
    class << self
      alias_method :name, :all
    end
    
  end
end