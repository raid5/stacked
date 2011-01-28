require 'spec_helper'

describe Stacked::User do
  subject { Stacked::User }
  context "class methods" do

    it "gathers the newest user" do
      subject.all(:sort => 'creation', :pagesize => 1).first.creation_date.should be_within(1.day)
    end

    it "gathers the oldest user" do
      subject.all(:sort => 'creation', :order => 'asc', :pagesize => 1).first.display_name.should eql("Community")
    end

    it "gathers the users by name" do
      subject.all(:sort => 'name', :filter => 'ryan', :pagesize => 1).first.display_name.should eql("ytbryan")
    end

    it "gathers users by reputation" do
      subject.all(:pagesize => 1).first.display_name.should eql("Jon Skeet")
    end

    it "gathers all the Ryan Bigg users" do
      # Limited to 1 result in case other people want to steal my name.
      subject.all(:filter => "Ryan Bigg", :pagesize => 1).first.display_name.should eql("Ryan Bigg")
    end
  end

  context "instance methods" do
    subject { Stacked::User.find(22656) }

    context "answers" do
      it "finds the user's answers" do
        subject.answers.should_not be_empty
        subject.answers.first.should be_is_a(Stacked::Answer)
      end

      it "finds the user's most recent answers" do
        subject.answers(:sort => 'activity', :pagesize => 2).should be_sorted_by(:last_activity_date, :desc)
      end
      
      it "finds the user's newest answers" do
        subject.answers(:sort => 'creation', :pagesize => 2).should be_sorted_by(:creation_date, :desc)
      end
      
      it "finds the user's most popular answers" do
        subject.answers(:sort => 'votes', :pagesize => 2).should be_sorted_by(:score, :desc)
      end
      
      it "finds the user's most viewed answers" do
        subject.answers(:sort => 'views', :pagesize => 2).should be_sorted_by(:view_count, :desc)
      end
    end

    context "comments" do
      it "finds some of the user's comments" do
        pending("Seems to break on Jon Skeet for some reason. See http://api.stackoverflow.com/1.0/users/22656/comments")
        subject.comments.should_not be_empty
        subject.comments.first.should be_is_a(Stacked::Comment)
      end

      it "finds the user's recent comments" do
        pending("Seems to break on Jon Skeet for some reason. See http://api.stackoverflow.com/1.0/users/22656/comments")
        subject.comments(:sort => 'creation').should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most awesome comments" do
        pending("Seems to break on Jon Skeet for some reason. See http://api.stackoverflow.com/1.0/users/22656/comments")
        subject.comments(:sort => 'votes').should be_sorted_by(:score, :desc)
      end

      it "finds all comments directed at a user" do
        # The "magic" numbers for the date range are "around" comment #2561833.
        # This method is a bit funny, why would you want this time-boxed?
        subject.comments_mentioning_user(133566, :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
      
      it "finds all comments directed at a user recently" do
        subject.comments_mentioning_user(133566, :sort => 'creation', :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
      
      it "finds all comments directed at a user by score" do
        subject.comments_mentioning_user(133566, :sort => 'votes', :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
    end

    context "favorites" do
      it "finds the user's favorite questions" do
        subject.favorites.should_not be_empty
        subject.favorites.first.should be_is_a(Stacked::Question)
      end

      it "can pass options to favorites" do
        subject.favorites.size.should >= 16
        subject.favorites(:pagesize => 1).size.should eql(1)
      end

      it "finds the most recent favorites" do
        subject.favorites(:sort => 'activity', :pagesize => 2).should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the most viewed favorites" do
        subject.favorites(:sort => 'views', :pagesize => 2).should be_sorted_by(:view_count, :desc)
      end

      it "finds the newest favorites" do
        subject.favorites(:sort => 'creation', :pagesize => 2).should be_sorted_by(:creation_date, :desc)
      end

      it "finds the favorites in the order they were made favorite" do
        # How the devil do you test this?
        subject.favorites(:sort => 'added', :pagesize => 1).first.should be_is_a(Stacked::Question)
      end

    end

    context "questions" do

      it "finds the user's questions" do
        question = subject.questions.first
        question.should be_is_a(Stacked::Question)
        question.owner.user_id.should eql(subject.user_id)
      end

      it "can pass options to questions" do
        subject.questions.size.should >= 21
        subject.questions(:pagesize => 1).size.should eql(1)
      end

      it "finds the user's recent questions" do
        questions = subject.questions(:sort => 'activity', :pagesize => 2)
        questions.should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the user's most viewed questions" do
        questions = subject.questions(:sort => 'views', :pagesize => 2)
        questions.should be_sorted_by(:view_count, :desc)
      end

      it "finds the user's newest questions" do
        questions = subject.questions(:sort => 'creation', :pagesize => 2)
        questions.should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most popular questions" do
        questions = subject.questions(:sort => 'votes', :pagesize => 2)
        questions.should be_sorted_by(:score, :desc)
      end
    end

    it "reputation changes" do
      change = subject.rep_changes(:pagesize => 1).first
      change.should be_is_a(Stacked::RepChange)
    end

    it "mentioned / mentions" do
      # Testing the mentioned method by way of aliases.
      subject.mentioned(:pagesize => 1).first.should be_is_a(Stacked::Comment)
    end

    it "timeline" do
      subject.timeline(:pagesize => 1).first.should be_is_a(Stacked::UserTimeline)
    end

    it "tags" do
      subject.tags(:pagesize => 1).first.should be_is_a(Stacked::Tag)
    end

    it "badges" do
      subject.badges(:pagesize => 1).first.name.should eql("Teacher")
    end

  end
end