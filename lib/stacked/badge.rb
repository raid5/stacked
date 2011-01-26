module Stacked
  class Badge < Base
    # attr_accessor :award_count,
    #               :badge_id,
    #               :description,
    #               :name,
    #               :rank,
    #               :tag_based

    # collection :tags

    #alias_method :id, :badge_id

    class << self
      #alias_method :name, :all
      
      def search(*args)
        raise Stacked::NotImplemented
      end
      
      def find(id, options = {})
        path = singular(id)
        p "Badge.find path => #{path}"
        parse_users(request(path, options))
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