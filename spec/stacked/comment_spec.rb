require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Comment do
  subject { Stacked::Comment }
  
  it "finds a single comment" do
    comment = Stacked::Comment.find(2561833)
    comment.should be_is_a(Stacked::Comment)
    comment.owner_user_id.should eql(22656)
  end
  
end