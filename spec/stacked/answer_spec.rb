require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Answer do
  context "class methods" do
    it "raises an error if all is called" do
      lambda { Stacked::Answer.all }.should raise_error(Stacked::NotImplemented, "The requested action is not available in the API.")
    end
  end
  it "finds the user for an answer" do
    Stacked::Answer.find(1237127).user.display_name.should eql("Daniel Vandersluis")
  end
  
  
end