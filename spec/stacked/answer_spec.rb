require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Answer do
  context "class methods" do
    it "raises an error if all is called" do
      lambda { Stacked::Answer.all }.should raise_error(Stacked::NotImplemented, "The requested action is not available in the API.")
    end
  end
  
  context "instance methods" do
    subject { Stacked::Answer.find(1237127) }
    it "finds the user for an answer" do
      subject.user.display_name.should eql("Daniel Vandersluis")
    end
  
    it "finds the question for an answer" do
      subject.question.should be_is_a(Stacked::Question)
    end
    
    aliases(:views      => :view_count,
            :up_votes   => :up_vote_count,
            :answer_id  => :id,
            :created_at => :creation_date,
            :updated_at => :last_edit_date)
    
  end
  
end