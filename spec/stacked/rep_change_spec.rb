require 'spec_helper'

describe Stacked::RepChange do
  # Being very particular about what Reputation we mean...
  subject { Stacked::User.find(22656).rep_changes(:fromdate => 1270132345, :todate => 1270132348).first }

  it "should be able to find the related post" do
    subject.post.should be_is_a(Stacked::Answer)
  end

  it "should be able to work out the score of a reputation" do
    # Yeah right, like anyone would ever vote down a Jon Skeet answer and live.
    subject.stub!(:negative_rep => 15)
    subject.score.should eql(0)
  end


end