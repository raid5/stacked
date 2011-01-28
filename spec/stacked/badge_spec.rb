require 'spec_helper'

describe Stacked::Badge do
  subject { Stacked::Badge }
  it "finds all badges" do
    subject.all.first.should be_is_a(Stacked::Badge)
  end

  it "finds all badges ordered by name" do
    subject.name.first.should be_is_a(Stacked::Badge)
  end

  it "finds all badges based on tags" do
    subject.tags.first.name.should eql(".htaccess")
  end

end