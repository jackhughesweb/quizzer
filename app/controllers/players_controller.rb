class PlayersController < ApplicationController
  include BroadcastHelper

  def new
    @game = Game.where("link_url = ?", params[:link_url]).first
    respond_to do |format|
      format.html { render :layout => "game" }
    end
  end

  def signup
    @game = Game.where("link_url = ?", params[:link_url]).first
    if @game.joinable?
      @player = Player.new
      respond_to do |format|
        format.html { render :layout => "game" }
      end
    end
  end

  def create
    @game = Game.where("link_url = ?", params[:link_url]).first
    if @game.joinable?
      @player = Player.new(player_params)
      @player.game_id = @game.id
      respond_to do |format|
        if @player.save
          @playerData = @player
          @playerData.passcode = 0
          broadcast("/g/#{@game.link_url}/players/new", @playerData.to_json)
          session[:player_id] = @player.id
          format.html { redirect_to playgame_path(@game.link_url), notice: 'Signed in' }
          format.json { render action: 'show', status: :created, location: @game }
        else
          format.html { render action: 'new' }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def login
    @game = Game.where("link_url = ?", params[:link_url]).first
    @player = Player.new
    respond_to do |format|
      format.html { render :layout => "game" }
    end
  end

  def join
    @game = Game.where("link_url = ?", params[:link_url]).first
    @player = Player.where("name = ?", player_params[:name]).where("passcode = ?", player_params[:passcode]).where("game_id = ?", @game.id).first
    if @player.blank?
      respond_to do |format|
        format.html { redirect_to playgame_path(@game.link_url), notice: 'Incorrect login details' }
      end
    else
      session[:player_id] = @player.id
      respond_to do |format|
        format.html { redirect_to playgame_path(@game.link_url), notice: 'Signed in' }
      end
    end

  end

  def logout
    @game = Game.where("link_url = ?", params[:link_url]).first
    session[:player_id] = ""
    respond_to do |format|
      format.html { redirect_to playgame_path(@game.link_url), notice: 'Signed out' }
    end

  end

  def logoutf
    session[:player_id] = ""
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Signed out' }
    end

  end

  private

  def player_params
    params.require(:player).permit(:name, :passcode)
  end
end
