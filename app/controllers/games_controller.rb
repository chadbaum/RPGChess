# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.all
  end

  def create
    @game = Game.create
    @game.white.update(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def join
    @game = Game.find(params[:id])
    @game.black.update(user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    # ADD AUTHENTICATION FOR CORRECT USERS
  end

  def update
    respond_to do |format|
    end
    @piece = Piece.find_by(game_id: params[:id], id: params[:piece_id])
    @piece.move!(x, y)
    respond_with @piece

    # private
    #
    # def piece_params
    #   params.require(:piece).permit(:x_position, :y_position, :moved)
    # end

  end
end
