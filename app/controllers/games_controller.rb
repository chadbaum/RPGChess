# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
  end

  def create
    @game = Game.new
    # set game_status
    @game.save!
    @game.white.user_id = current_user.id
    @game.white.save!
    @game.populate!
  end

  def show
    @piece_positions = Game.find(params[:id]).pieces
  end

  def update
    @game = Game.find(params[:id])
    @piece = @game.pieces.find(params[:piece_id])
    x = params[:x_position].to_i
    y = params[:y_position].to_i
    @piece.move!(x, y)
  end

  private

  def game_params
    params.require(:game)
  end
end
