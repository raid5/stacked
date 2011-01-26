module Stacked
  class Tag < Base
    # attr_accessor :count,
    #               :name

    # collection :popular, :name, :recent
    
    class << self
      def find(*args)
        raise Stacked::NotImplemented
      end
      def search(*args)
        raise Stacked::NotImplemented
      end
    end

  end
end