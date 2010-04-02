module Spec
  module Matchers
    class Sortedby #:nodoc:
      def initialize(field=nil, direction=:asc)
        @field = field
        @direction = direction
        @pretty_direction = direction == :desc ? "descending" : "ascending"
        # Placeholder
      end

      def matches?(receiver)
        if @direction.to_sym == :desc
          receiver[0].send(@field) > receiver[1].send(@field)
        elsif @direction.to_sym == :asc
          receiver[0].send(@field) < receiver[1].send(@field)
        else
          raise "direction must be either :desc or :asc or their String counterparts"
        end
      end

      def failure_message
        "Expected result set to be sorted by #{@field} in #{@pretty_direction} order, but was not."
      end

    end

    def be_sorted_by(field=nil, direction=:asc)
      Spec::Matchers::Sortedby.new(field, direction)
    end
  end
end
