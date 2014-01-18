require 'spec_helper'

describe "Questions" do

  before(:each) do
    login
  end

  after(:each) do
    logout
  end

  it "is accessible from a category" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.quiz_id = quiz.id
    category.save
    visit quiz_categories_path(quiz.id)
    find(:css, "a\#queshowbtn#{quiz.id}#{category.id}", :text => 'Show Questions').click
  end
  it "allows user to create a new question" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.quiz_id = quiz.id
    category.save
    visit quiz_category_questions_path(quiz.id, category.id)
    question = FactoryGirl.create(:question)
    click_link "New Question"
    fill_in "Question", :with => question.question
    fill_in "Correct answer", :with => question.correct_answer
    fill_in "Altone answer", :with => question.altone_answer
    fill_in "Alttwo answer", :with => question.alttwo_answer
    fill_in "Altthree answer", :with => question.altthree_answer
    click_button "Create Question"
  end
  it "allows user to view an existing question" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.quiz_id = quiz.id
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.category_id = category.id
    question.save
    visit quiz_category_questions_path(quiz.id, category.id)
  end
  it "allows user to edit an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.quiz_id = quiz.id
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.category_id = category.id
    question.save
    visit quiz_category_questions_path(quiz.id, category.id)
    find(:css, "a\#queeditbtn#{quiz.id}#{category.id}#{question.id}", :text => 'Edit').click
    fill_in "Altone answer", :with => "12"
    click_button "Update Question"
  end
  it "allows user to delete an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.quiz_id = quiz.id
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.category_id = category.id
    question.save
    visit quiz_category_questions_path(quiz.id, category.id)
    find(:css, "a\#quedesbtn#{quiz.id}#{category.id}#{question.id}", :text => 'Destroy').click
  end
  it "should require a question" do
    Question.create(:question => "").should_not be_valid
  end
  it "should require a correct answer" do
    Question.create(:correct_answer => "").should_not be_valid
  end
  it "should require an alternative incorrect answer (one)" do
    Question.create(:altone_answer => "").should_not be_valid
  end
  it "should require an alternative incorrect answer (two)" do
    Question.create(:alttwo_answer => "").should_not be_valid
  end
  it "should require an alternative incorrect answer (three)" do
    Question.create(:altthree_answer => "").should_not be_valid
  end
end
