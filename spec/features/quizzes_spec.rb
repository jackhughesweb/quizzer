require 'spec_helper'

describe "Quizzes" do
  it "allows user to create a new quiz" do
    quiz = FactoryGirl.create(:quiz)
    visit quizzes_path
    click_link "New Quiz"
    fill_in "Name", :with => quiz.name
    click_button "Create Quiz"
  end
  it "allows user to view an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quiz_path(quiz.id)
  end
  it "allows user to edit an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quiz_path(quiz.id)
    click_link "Edit"
    fill_in "Name", :with => "New Christmas Quiz"
    click_button "Update Quiz"
    page.should have_content("New Christmas Quiz")
  end
  it "allows user to delete an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quiz_path(quiz.id)
    click_link "Edit"
    click_link "Destroy"
  end
  it "should require a name" do
    Quiz.create(:name => "").should_not be_valid
  end
end
