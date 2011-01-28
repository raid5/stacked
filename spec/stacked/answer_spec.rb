require 'spec_helper'

describe Stacked::Answer do
  context "class methods" do
    it "raises an error if all is called" do
      lambda { Stacked::Answer.all }.should raise_error(Stacked::NotImplemented, "The requested action is not available in the API.")
    end
  end

  context "instance methods" do
    subject { Stacked::Answer.find(1237127, :body => true) }
    it "finds the user for an answer" do
      subject.owner.should be_is_a(Stacked::User)
      subject.owner.display_name.should eql("Daniel Vandersluis")
    end

    it "finds the question for an answer" do
      subject.question.should be_is_a(Stacked::Question)
    end

    it "has a body" do
      subject.body.should_not be_blank
    end
  end

end