require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Base do
  context "common methods" do
    # We cannot use Stacked::Base here obviously because SO does not have Bases!
    # So we use User instead.
    subject { Stacked::User }

    it "retrieves a list of a resource" do
      subject.all.all? { |u| u.is_a?(subject) }.should be_true
    end

    it "paginates through the resource" do
      subject.all.first.should_not eql(subject.all(:page => 2).first)
    end

    it "limits the results" do
      subject.all(:pagesize => 1).size.should eql(1)
    end
    
    it "stats" do
      Stacked::Base.stats.keys.sort.should eql(["answers_per_minute", "api_version", "badges_per_minute", "questions_per_minute", "total_answers", "total_badges", "total_comments", "total_questions", "total_unanswered", "total_users", "total_votes"])
    end

  end

end