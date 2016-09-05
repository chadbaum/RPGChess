class PiecesController < ApplicationController
  respond_to :json

  def move
    @piece = Piece.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    @piece.move!(x, y)
  end
end
