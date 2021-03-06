class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :require_login
  before_action :set_quiz

  # GET /categories
  # GET /categories.json
  def index
    @categories = @quiz.categories.order('position')
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.quiz_id = @quiz.id

    respond_to do |format|
      if @category.save
        format.html { redirect_to quiz_categories_path(@quiz), notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to quiz_categories_path(@quiz), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:category].each_with_index do |id, index|
      Category.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to quiz_categories_path(@quiz) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

    def require_login
      unless user_signed_in?
        redirect_to new_user_session_url, flash: { error: "Please login first"}
      end
    end

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end
end
