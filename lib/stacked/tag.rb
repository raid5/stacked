module Stacked
  class Tag < Base

    class << self
      def find(*args)
        raise Stacked::NotImplemented
      end
    end

  end
end