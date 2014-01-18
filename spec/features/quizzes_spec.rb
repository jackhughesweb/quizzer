require 'spec_helper'

describe "Quizzes" do

  before(:each) do
    login
  end

  after(:each) do
    logout
  end

  it "allows user to create a new quiz" do
    quiz = FactoryGirl.create(:quiz)
    visit quizzes_path
    click_link "New Quiz"
    fill_in "Name", :with => quiz.name
    click_button "Create Quiz"
  end
  it "allows user to edit an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quizzes_path
    find(:css, "a\#quieditbtn#{quiz.id}", :text => 'Edit').click
    fill_in "Name", :with => "New Christmas Quiz"
    click_button "Update Quiz"
    page.should have_content("New Christmas Quiz")
  end
  it "allows user to delete an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quizzes_path
    find(:css, "a\#quidesbtn#{quiz.id}", :text => 'Destroy').click
  end
  it "should require a name" do
    Quiz.create(:name => "").should_not be_valid
  end
end
