require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Question do
  
  subject { Stacked::Question }
  it "gets a list of all questions" do
    subject.all.all? { |q| q.is_a?(subject) }.should be_true
  end
  
  it "active" do
    subject.active(:pagesize => 1).first.last_activity_date.should be_within(1.day)
  end
  
  it "newest" do
    subject.newest(:pagesize => 1).first.creation_date.should be_within(1.day)
  end
  
  it "featured" do
    pending("There currently doesn't appear to be a field to see if a question has a bounty.")
    subject.featured(:pagesize => 1).first.bounty.should eql(100)
  end
  
  it "hot" do
    pending("How do you determine if a question is hot? Perhaps it's the number of views.")
    subject.hot(:pagesize => 1).first
  end
  
  
end