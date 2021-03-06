class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_filter :require_login

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.order('position')
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quizzes_path, notice: 'Quiz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quiz }
      else
        format.html { render action: 'new' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quizzes_path, notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:quiz].each_with_index do |id, index|
      Quiz.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def require_login
      unless user_signed_in?
        redirect_to new_user_session_url, flash: { error: "Please login first"}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name)
    end
end
