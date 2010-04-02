require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Question do
  
  subject { Stacked::Question }
  it "gets a list of all questions" do
    subject.all.all? { |q| q.is_a?(subject) }.should be_true
  end
  
  it "gets a list of questions with comments" do
    pending("Cannot currently get a list of questions with comments")
    subject.all(:comments => true)
  end
  
  it "active" do
    subject.active(:pagesize => 1).first.last_activity_date.should be_within(1.day)
  end
  
  it "newest" do
    subject.newest(:pagesize => 1).first.creation_date.should be_within(1.day)
  end
  
  it "featured" do
    subject.featured(:pagesize => 1).first.score.should eql(13)
  end
  
  it "hot" do
    pending("How do you determine if a question is hot? Perhaps it's the number of views.")
    subject.hot(:pagesize => 1).first
  end
  
  it "month" do
    subject.month(:pagesize => 1).first.creation_date.should be_within(1.month)
  end
  
  it "week" do
    subject.week(:pagesize => 1).first.creation_date.should be_within(1.week)
  end
  
  it "votes" do
    subject.votes(:pagesize => 1).first.up_vote_count.should eql(1186)
  end
  
  it "retreives comments with a question when asked" do
    question = subject.find(1236996, :comments => true)
    question.title.should eql("Calculating the distance between two times")
    question.comments.should_not be_empty
    question.comments.first.should be_is_a(Stacked::Comment)
  end
  
end