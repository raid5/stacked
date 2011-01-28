require 'spec_helper'

describe SortedByMatcher::Sortedby do
  before do
    @questions = []
    @questions << Stacked::Question.new(:last_edit_date => Time.now.to_i)
    @questions << Stacked::Question.new(:last_edit_date => (Time.now + 5.days).to_i)
  end

  subject { @questions }

  it "sorted by" do
    subject.should be_sorted_by(:last_edit_date)
  end

  it "sorted by reverse" do
    subject.reverse.should be_sorted_by(:last_edit_date, :desc)
  end

  it "fails with an understandable error message" do
    lambda { subject.reverse.should be_sorted_by(:last_edit_date, :asc) }.should raise_error("Expected result set to be sorted by last_edit_date in ascending order, but was not.")
  end

end