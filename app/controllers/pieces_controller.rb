class PiecesController < ApplicationController
  respond_to :json

  def move
    @piece = Piece.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    @piece.move!(x, y)
  end

  def valid_moves
    @piece = Piece.find(params[:id])
    render json: @piece.generate_valid_moves
  end

  def refresh
    @game = Game.find(params[:id])
    render partial: 'scoreboard'
  end
end
