require 'spec_helper'

describe Stacked::Question do
  
  context "class methods" do
    
    subject { Stacked::Question }
    
    it "gets a list of all questions" do
      pending("Crack::ParseError: Invalid JSON string")
      subject.all.all? { |q| q.is_a?(subject) }.should be_true
    end
    
    it "gets a list of questions with comments" do
      pending("look into more")
      subject.all(:pagesize => 1).first.comments.should be_nil
      subject.all(:comments => true, :pagesize => 1).first.comments.should_not be_nil
    end
    
    it "search" do
      question = subject.search(:intitle => 'ImageMagick', :pagesize => 1).first
      question.title.should =~ /ImageMagick/i
    end

    it "unanswered" do
      question = subject.unanswered(:pagesize => 1).first
      question.should be_is_a(Stacked::Question)
      question.answers.should be_blank
    end

    it "tagged" do
      question = subject.all(:tagged => ["ruby", "ruby-on-rails"].join(';'), :pagesize => 1).first
      question.tags.map(&:name).should include("ruby")
      question.tags.map(&:name).should include("ruby-on-rails")
    end
  end

  context "instance methods" do
    before(:all) do
      # Ensure only one API request per resouce
      @question = Stacked::Question.find(1236996, :comments => true, :body => true)
    end

    it "is the right question" do
      @question.title.should eql("Calculating the distance between two times")
    end

    it "has a body" do
      @question.body.should_not be_blank
    end
    
    it "retreives comments" do
      @question.comments.should_not be_empty
      @question.comments.first.should be_is_a(Stacked::Comment)
    end

    it "retreives answers" do
      @question.answers.should_not be_empty
      @question.answers.first.should be_is_a(Stacked::Answer)
    end

    it "retreives tags" do
      @question.tags.should_not be_empty
      @question.tags.first.should be_is_a(Stacked::Tag)
    end

    it "finds the user for a question" do
      @question.owner.should be_is_a(Stacked::User)
    end

    it "finds the accepted answer" do
      @question.accepted_answer.should be_is_a(Stacked::Answer)
    end

    it "shows the timeline of the question" do
      @question.timeline.first.should be_is_a(Stacked::PostTimeline)
    end

  end

end