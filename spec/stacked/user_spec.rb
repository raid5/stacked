require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::User do
  it "retrieves a list of users" do
    Stacked::User.all.all? { |u| u.is_a?(Stacked::User) }.should be_true
  end

  it "paginates through the users" do
    Stacked::User.all.first.should_not eql(Stacked::User.all(:page => 2).first)
  end

  it "limits the results to just one" do
    Stacked::User.all(:pagesize => 1).size.should eql(1)
  end

  it "gathers the newest user" do
    within_the_last_day = Time.at(Stacked::User.newest(:pagesize => 1).first.creation_date) > Time.now - 1.day
    within_the_last_day.should be_true
  end
  
  it "gathers the oldest user" do
    Stacked::User.oldest(:pagesize => 1).first.name.should eql("Community")
  end
end