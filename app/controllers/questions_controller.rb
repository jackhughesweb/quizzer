class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_filter :require_login
  before_action :set_quiz
  before_action :set_category

  # GET /questions
  # GET /questions.json
  def index
    @questions = @category.questions.order('position')
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.category_id = @category.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to quiz_category_questions_path(@quiz.id, @category.id), notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to quiz_category_questions_path(@quiz.id, @category.id), notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:question].each_with_index do |id, index|
      Question.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to quiz_category_questions_url(@quiz.id, @category.id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :correct_answer, :altone_answer, :alttwo_answer, :altthree_answer)
    end

    def require_login
      unless user_signed_in?
        redirect_to new_user_session_url, flash: { error: "Please login first"}
      end
    end

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end

    def set_category
      @category = @quiz.categories.find(params[:category_id])
    end
end
