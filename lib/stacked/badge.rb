module Stacked
  # Stacked::Badge class.
  class Badge < Base
    attr_accessor :award_count,
                  :badge_id,
                  :badges_recipients_url,
                  :description,
                  :name,
                  :rank,
                  :tag_based

    class << self
      # All users who have been awarded the specific badge.
      def find(id, options = {})
        parse_users(request(singular(id), options))
      end

      # All standard, non-tag-based badges.
      def name(options={})
        records(path + "/name", options)
      end
      
      # All tag-based badges
      def tags(options={})
        records(path + "/tags", options)
      end
    end

  end
end