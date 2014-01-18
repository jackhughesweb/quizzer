class AnswersController < ApplicationController

  include BroadcastHelper

  def new
    @answer = Answer.new(answer_params)
    @answer.player_id = session[:player_id]
    @game = Game.where("link_url = ?", params[:link_url]).first
    @answer.game_id = @game.id
    respond_to do |format|
      if @answer.save
        @player = Player.find(session[:player_id])
        broadcast("/g/#{@game.link_url}/answers", @player.to_json)
        format.html { render :layout => "blank" }
      end
    end
  end

  private

  def answer_params
    params.permit(:answer, :question_id)
  end

end
