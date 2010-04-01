require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::User do
  subject { Stacked::User }
  context "class methods" do
    it "retrieves a list of users" do
      subject.all.all? { |u| u.is_a?(subject) }.should be_true
    end

    it "paginates through the users" do
      subject.all.first.should_not eql(subject.all(:page => 2).first)
    end

    it "limits the results to just one" do
      subject.all(:pagesize => 1).size.should eql(1)
    end

    it "gathers the newest user" do
      within_the_last_day = Time.at(subject.newest(:pagesize => 1).first.creation_date) > Time.now - 1.day
      within_the_last_day.should be_true
    end
  
    it "gathers the oldest user" do
      subject.oldest(:pagesize => 1).first.name.should eql("Community")
    end
    
    it "gathers the users by name" do
      subject.name(:pagesize => 1).first.name.should eql("ricree")
    end
  
    it "gathers all the Ryan Bigg users" do
      # Limited to 1 result in case other people want to steal my name.
      subject.filter("Ryan Bigg", :pagesize => 1).first.name.should eql("Ryan Bigg")
    end
  end
  
  context "instance methods" do
    let(:attributes) { Stacked::Spec::Attributes.user }
    subject { Stacked::User.new(attributes) }
    
    { "display_name" => "name",
      "user_type" => "type", 
      "user_id" => "id",
      "gravatar" => "email_hash",
    }.each do |original, new|    
      it "#{original} is available as #{name}" do
        subject.name.should eql(subject.display_name)
      end
    end
  end
end