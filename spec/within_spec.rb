require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Spec::Matchers::Within do
  it "is within one day" do
    time = Time.now - 5.minutes
    time.should be_within(1.day)
  end
  
  it "is fine with integers" do
    time = Time.now.to_i
    time.should be_within(1.day)
  end
  
end