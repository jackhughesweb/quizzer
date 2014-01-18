class GamesController < ApplicationController
  before_filter :require_login, only: [:index, :create, :destroy, :show, :update, :dashboard, :start, :nextquestion]

  include BroadcastHelper

  # GET /categories
  # GET /categories.json
  def index
    @games = Game.all
    @game = Game.new
  end

  # POST /categories
  # POST /categories.json
  def create
    @game = Game.new(game_params)
    @game.currentcategory = 0
    @game.currentquestion = 0
    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @game = Game.find(params[:id])
    @players = Player.where("game_id = ?", @game.id)
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_path(@game), notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_path }
      format.json { head :no_content }
    end
  end

  def playgame
    @game = Game.where("link_url = ?", params[:link_url]).first
    @players = Player.where("game_id = ?", @game.id)
    session[:player_id] ||= ""
    if session[:player_id] != ""
      @player = Player.where("game_id = ?", @game.id).find(session[:player_id])
      respond_to do |format|
        format.html { render :layout => "game" }
      end
    else
      respond_to do |format|
        format.html { redirect_to newplayer_path(@game.link_url) }
      end
    end
  end

  def dashboard
    @game = Game.where("link_url = ?", params[:link_url]).first
    @players = Player.where("game_id = ?", @game.id)
    @quiz = Quiz.find(@game.quiz_id)
    @categories = Category.order('position').where("quiz_id = ?", @quiz.id)
    if @game.currentcategory > 0 && @game.currentquestion == 0
      @category = Category.where("quiz_id = ?", @quiz.id)[@game.currentcategory - 1]
    end
    if @game.currentcategory > 0 && @game.currentquestion > 0
      @category = @categories[@game.currentcategory - 1]
      @questions = Question.order('position').where("category_id = ?", @category.id)
      @question = @questions[@game.currentquestion - 1]
      @answerarray = [@question.correct_answer, @question.altone_answer, @question.alttwo_answer, @question.altthree_answer].shuffle
      @question.correct_answer = @answerarray[0]
      @question.altone_answer = @answerarray[1]
      @question.alttwo_answer = @answerarray[2]
      @question.altthree_answer = @answerarray[3]
      broadcast("/g/#{@game.link_url}/questions", @question.to_json)
    end
    if @game.currentcategory > 0 && @game.currentcategory > @categories.count
      respond_to do |format|
        format.html { redirect_to gameresults_path(@game.link_url) }
      end
    else
      respond_to do |format|
        format.html { render :layout => "dashboard" }
      end
    end
  end

  def start
    @game = Game.where("link_url = ?", params[:link_url]).first
    @players = Player.where("game_id = ?", @game.id)
    @game.currentcategory = 1
    @game.currentquestion = 0
    @game.save
    respond_to do |format|
      format.html { redirect_to gamedashboard_path(@game.link_url) }
    end
  end

  def nextquestion
    @game = Game.where("link_url = ?", params[:link_url]).first
    @players = Player.where("game_id = ?", @game.id)
    @quiz = Quiz.find(@game.quiz_id)
    @categories = Category.order('position').where("quiz_id = ?", @quiz.id)
    @category = @categories[@game.currentcategory - 1]
    @questions = Question.order('position').where("category_id = ?", @category.id)
    if @game.currentquestion == @questions.count
      @game.currentcategory += 1
      @game.currentquestion = 0
    else
      @game.currentquestion += 1
    end
    @game.save
    if @game.currentquestion >= @questions.count && @game.currentcategory > @categories.count
      respond_to do |format|
        format.html { redirect_to gameresults_path(@game.link_url) }
      end
    else
      respond_to do |format|
        format.html { redirect_to gamedashboard_path(@game.link_url) }
      end
    end
  end

  def results
    @game = Game.where("link_url = ?", params[:link_url]).first
    @players = Player.where("game_id = ?", @game.id)
    @quiz = Quiz.find(@game.quiz_id)
    @categories = Category.order('position').where("quiz_id = ?", @quiz.id)
    @playerscores = []
    @categories.each do |category|
      category.questions.each do |question|
        @answers = Answer.where("question_id = ?", question.id).where("game_id = ?", @game.id)
        @answers.each do |answer|
          if answer.answer == question.correct_answer
            if @playerscores[answer.player.id]
              @playerscores[answer.player.id] += 1
            else
              @playerscores[answer.player.id] = 1
            end
          else
          end
        end
      end
    end
    respond_to do |format|
      format.html { render :layout => "dashboard" }
    end
  end

  private

  def game_params
    params.require(:game).permit(:quiz_id, :link_url, :joinable)
  end

  def require_login
      unless user_signed_in?
        redirect_to new_user_session_url, flash: { error: "Please login first"}
      end
    end
end
