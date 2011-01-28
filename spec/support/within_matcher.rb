module WithinMatcher
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
      "Expected time to be within #{@receiver.inspect}, but was not."
    end

  end

  def be_within(receiver=nil)
    Within.new(receiver)
  end
end