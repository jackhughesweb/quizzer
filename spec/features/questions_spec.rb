require 'spec_helper'

describe "Questions" do
  it "is accessible from a category" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    visit quiz_category_path(quiz.id, category.id)
    click_link "View Questions"
  end
  it "allows user to create a new question" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
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
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.save
    visit quiz_category_question_path(quiz.id, category.id, question.id)
  end
  it "allows user to edit an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.save
    visit quiz_category_question_path(quiz.id, category.id, question.id)
    click_link "Edit"
    fill_in "Altone answer", :with => "12"
    click_button "Update Question"
  end
  it "allows user to delete an existing quiz" do
    quiz = Quiz.new(name: "Christmas Quiz")
    quiz.save
    category = Category.new(name: "Pop Music Round")
    category.save
    question = Question.new(question: "How many reindeer does Santa have?", correct_answer: "9", altone_answer: "1", alttwo_answer: "2", altthree_answer: "3")
    question.save
    visit quiz_category_question_path(quiz.id, category.id, question.id)
    click_link "Edit"
    click_link "Destroy"
  end
end
