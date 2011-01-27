module Stacked
  # Stacked::Comment class.
  class Comment < Base

    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end

    # Finds the user this comment was in reply to.
    # nil if no user.
    def reply_to
      Stacked::User.find(reply_to_user_id) if reply_to_user_id
    end

    # The owner of this comment.
    def owner
      @owner ||= Stacked::User.find(owner_user_id)
    end
  end
end