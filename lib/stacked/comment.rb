module Stacked
  class Comment < Base
    attr_accessor :body,
                  :comment_id,
                  :creation_date,
                  :edit_count,
                  :owner_display_name,
                  :owner_user_id,
                  :post_id,
                  :post_type,
                  :reply_to_user_id,
                  :score

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

    alias_method :created_at, :creation_date
    alias_method :id, :comment_id
    alias_method :user, :owner
    alias_method :edits, :edit_count

  end
end