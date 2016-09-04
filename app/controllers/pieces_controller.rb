class PiecesController < ApplicationController
  respond_to :json
  
  def move
    @piece = Piece.find(params[:id])
    x = params[:x].to_i
    y = params[:y].to_i
    @piece.move!(x, y)
    respond_with @piece

    # private
    #
    # def piece_params
    #   params.require(:piece).permit(:x_position, :y_position, :moved)
    # end

  end
end
