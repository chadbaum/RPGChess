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
    @piece_positions = Game.find(params[:id]).pieces
  end

  def new
    @game = Game.new
  end

  def update
    STDERR.puts params.inspect

    @game = Game.find(params[:id])
    @piece_positions =  @game.pieces.find(params[:piece_id])
    @piece_positions.update_attributes(:x_position => params[:x_position], :y_position => params[:y_position])

    # render json: @piece_positions
  end

  private

  # def game_params
  #   params.require(:game)
  # end

  # def piece_params
  #   params.require(:piece).permit(:id, :x_position, :y_position)
  # end
end
