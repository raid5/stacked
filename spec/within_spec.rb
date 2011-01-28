require 'spec_helper'

describe WithinMatcher::Within do
  it "is within one day" do
    time = Time.now - 5.minutes
    time.should be_within(1.day)
  end

  it "is fine with integers" do
    time = Time.now.to_i
    time.should be_within(1.day)
  end

  it "fails with an understandable error message" do
    time = Time.now - 5.days
    lambda { time.should be_within(5.seconds) }.should raise_error("Expected time to be within 5 seconds, but was not.")
  end

end