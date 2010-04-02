require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::User do
  subject { Stacked::User }
  context "class methods" do

    it "gathers the newest user" do
      subject.newest(:pagesize => 1).first.creation_date.should be_within(1.day)
    end

    it "gathers the oldest user" do
      subject.oldest(:pagesize => 1).first.name.should eql("Community")
    end

    it "gathers the users by name" do
      subject.name(:pagesize => 1).first.name.should eql("[ebarrera]")
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

    # Yes I'm using "favourites" and not "favorites"
    # This has the intended side-effect of testing the existance of
    # the alias as well as the real method
    it "finds the user's favourite questions" do
      subject.favourites.should_not be_empty
      subject.favourites.first.should be_is_a(Stacked::Question)
    end

    it "can pass options to favourites" do
      subject.favourites.size.should eql(19)
      subject.favourites(:pagesize => 1).size.should eql(1)
    end

    it "finds the user's questions" do
      question = subject.questions.first
      question.should be_is_a(Stacked::Question)
      question.owner_user_id.should eql(subject.id)
    end

    it "can pass options to questions" do
      subject.questions.size.should eql(22)
      subject.questions(:pagesize => 1).size.should eql(1)
    end

    it "finds the user's recent questions" do
      questions = subject.recent_questions(:pagesize => 2)
      questions.should be_sorted_by(:last_edit_date, :desc)
    end

    it "finds the user's most viewed questions" do
      questions = subject.questions_by_views(:pagesize => 2)
      questions.should be_sorted_by(:views)
    end
  end
end