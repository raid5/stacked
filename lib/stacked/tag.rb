module Stacked
  # Stacked::Tag class.
  class Tag < Base

    class << self
      def find(*args)
        raise Stacked::NotImplemented
      end
    end

  end
end