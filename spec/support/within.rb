module Spec
  module Matchers
    class Within #:nodoc:
      def initialize(receiver=nil, &block)
        @receiver = receiver
        # Placeholder
      end
      
      def matches?(time)
        time = Time.at(time) if time.is_a?(Numeric)
        @receiver.ago < time
      end
      
      def failure_message
        duration = ActiveSupport::Duration.new(1, [[:seconds, @distance]])
        "Expected blah to be within the last blah"
      end
      
    end
    
    def be_within(receiver=nil, &block)
      Spec::Matchers::Within.new(receiver, &block)
    end
  end
end
