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
    
    it "gathers users by reputation" do
      subject.reputation(:pagesize => 1).first.name.should eql("Jon Skeet")
    end

    it "gathers all the Ryan Bigg users" do
      # Limited to 1 result in case other people want to steal my name.
      subject.filter("Ryan Bigg", :pagesize => 1).first.name.should eql("Ryan Bigg")
    end
  end

  context "instance methods" do
    subject { Stacked::User.find(22656) }

    aliases(
            :answers      => :answer_count,
            :created_at   => :creation_date,
            :display_name => :name,
            :down_votes   => :down_vote_count,
            :gravatar     => :email_hash,
            :up_votes     => :up_vote_count,
            :user_id      => :id,
            :user_type    => :type,
            :views        => :view_count
            )

    context "comments" do
      it "finds some of the user's comments" do
        subject.comments.should_not be_empty
        subject.comments.first.should be_is_a(Stacked::Comment)
      end

      it "finds the user's recent comments" do
        subject.recent_comments.should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most awesome comments" do
        subject.popular_comments.should be_sorted_by(:score, :desc)
      end

      it "finds all comments directed at a user" do
        # The "magic" numbers for the date range are "around" comment #2561833.
        # This method is a bit funny, why would you want this time-boxed?
        subject.directed_at(133566, :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
    end

    context "favourites" do

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

      it "finds the most recent favourites" do
        subject.recent_favourites(:pagesize => 2).should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the most viewed favourites" do
        subject.favourites_by_views(:pagesize => 2).should be_sorted_by(:view_count, :desc)
      end

      it "finds the newest favourites" do
        subject.newest_favourites(:pagesize => 2).should be_sorted_by(:creation_date, :desc)
      end

      it "finds the favourites in the order they were made favourite" do
        # How the devil do you test this?
        subject.added_favourites(:pagesize => 1).first.should be_is_a(Stacked::Question)
      end

    end

    context "questions" do

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
        questions.should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the user's most viewed questions" do
        questions = subject.questions_by_views(:pagesize => 2)
        questions.should be_sorted_by(:view_count, :desc)
      end

      it "finds the user's newest questions" do
        questions = subject.newest_questions(:pagesize => 2)
        questions.should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most popular questions" do
        questions = subject.popular_questions(:pagesize => 2)
        questions.should be_sorted_by(:score, :desc)
      end
    end

    it "reputations" do
      reputation = subject.reputations(:pagesize => 1).first
      reputation.should be_is_a(Stacked::Reputation)
    end

    it "mentioned / mentions" do
      # Testing the mentioned method by way of aliases.
      subject.mentions(:pagesize => 1).first.should be_is_a(Stacked::Comment)
    end

    it "timeline" do
      subject.timeline(:pagesize => 1).first.should be_is_a(Stacked::Usertimeline)
    end
    
    it "tags" do
      subject.tags(:pagesize => 1).first.should be_is_a(Stacked::Tag)
    end

  end
end