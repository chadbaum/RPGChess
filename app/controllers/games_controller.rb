# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
  end

  def create
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    @piece_positions = Game.find(params[:id]).pieces
    if @game.black_check?
      flash[:black_check] = "Black King is under the Check!"
    elsif @game.white_check?
      flash[:white_check] = "White King is under the Check!"
    end
  end

  def new
    @game = Game.new
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
