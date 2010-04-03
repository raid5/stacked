require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Comment do
  subject { Stacked::Comment }
  
  context "class methods" do
    
    it "raises an error if all is called" do
      lambda { Stacked::Comment.all }.should raise_error(Stacked::NotImplemented, "The requested action is not available in the API.")
    end
  
    it "finds a single comment" do
      comment = Stacked::Comment.find(2561833)
      comment.should be_is_a(Stacked::Comment)
      comment.owner_user_id.should eql(22656)
    end
  end
  
  context "instance methods" do
    subject { Stacked::Comment.find(2561833) }
    
    it "finds the related post for this comment" do
      subject.post.should be_is_a(Stacked::Answer)
    end
  end
  
end