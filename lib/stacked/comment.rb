module Stacked
  # Stacked::Comment class.
  class Comment < Base
    attr_accessor :body,
                  :comment_id,
                  :creation_date,
                  :edit_count,
                  :owner,
                  :post_id,
                  :post_type,
                  :reply_to_user,
                  :score
                  
    alias_method :reply_to_d, :creation_date

    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end
    
    # Helper method for creating Stacked::User object when initializing new Stacked::Comment objects.
    def owner=(attributes)
      @owner = User.new(attributes)
    end
    
    # Helper method for creating Stacked::User object when initializing new Stacked::Comment objects.
    def reply_to_user=(attributes)
      @reply_to_user = User.new(attributes)
    end
  end
end