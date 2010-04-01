require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Stacked" do
  it "retrieves a list of users" do
    Stacked::User.all.all? { |u| u.is_a?(Stacked::User) }.should be_true
  end
end
