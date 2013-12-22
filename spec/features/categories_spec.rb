require 'spec_helper'

describe "Categories" do
  it "is accessible from a quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quiz_path(quiz.id)
    click_link "View Categories"
  end
  it "allows user to create a new category" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    visit quiz_categories_path(quiz.id)
    category = FactoryGirl.create(:category)
    click_link "New Category"
    fill_in "Name", :with => category.name
    click_button "Create Category"
  end
  it "allows user to view an existing category" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    visit quiz_category_path(quiz.id, category.id)
  end
  it "allows user to edit an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    visit quiz_category_path(quiz.id, category.id)
    click_link "Edit"
    fill_in "Name", :with => "Christmas Music Round"
    click_button "Update Category"
  end
  it "allows user to delete an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    visit quiz_category_path(quiz.id, category.id)
    click_link "Edit"
    click_link "Destroy"
  end
  it "should require a name" do
    Category.create(:name => "").should_not be_valid
  end
end
