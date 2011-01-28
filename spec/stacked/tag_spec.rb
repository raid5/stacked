require 'spec_helper'

describe Stacked::Tag do
  subject { Stacked::Tag }
  
  it "finds all the tags" do
    subject.all(:pagesize => 1).first.name.should eql("c#")
  end

  it "finds the popular tags" do
    subject.all(:sort => 'popular', :pagesize => 2).should be_sorted_by(:count, :desc)
  end

  it "finds the tags ordered by name" do
    subject.all(:sort => 'name', :order => 'asc', :pagesize => 2).should be_sorted_by(:name, :asc)
  end

  it "finds the tags used recently" do
    subject.all(:sort => 'activity', :pagesize => 2).size.should eql(2)
  end
end