module Stacked
  # Stacked::Tag class.
  class Tag < Base
    attr_accessor :count,
                  :fulfills_required,
                  :name,
                  :restricted_to,
                  :user_id

    class << self
      def find(*args)
        raise Stacked::NotImplemented
      end
    end

  end
end