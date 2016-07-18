class Game < ActiveRecord::Base
  has_many :pieces
  has_many :players

  after_create :populate_board!

  def populate_board!


    # Black Pieces of the board
    (0..7).each do |i|
      Piece.create(type: 'Pawn', game_id: id, x_position: i, y_position: 1, color: "black")
    end

    Piece.create(type: 'Rook',game_id: id, x_position: 0, y_position: 0, color: "black")
    Piece.create(type: 'Rook',game_id: id, x_position: 7, y_position: 0, color: "black")

    Piece.create(type: 'Knight',game_id: id, x_position: 1, y_position: 0, color: "black")
    Piece.create(type: 'Knight',game_id: id, x_position: 6, y_position: 0, color: "black")

    Piece.create(type: 'Bishop',game_id: id, x_position: 2, y_position: 0, color: "black")
    Piece.create(type: 'Bishop',game_id: id, x_position: 5, y_position: 0, color: "black")

    Piece.create(type: 'Queen',game_id: id, x_position: 3, y_position: 0, color: "black")
    Piece.create(type: 'King',game_id: id, x_position: 4, y_position: 0, color: "black")


    # White Pieces of the board
    (0..7).each do |i|
      Piece.create(type: 'Pawn',game_id: id, x_position: i, y_position: 6, color: "white")
    end

    Piece.create(type: 'Rook',game_id: id, x_position: 0, y_position: 7, color: "white")
    Piece.create(type: 'Rook',game_id: id, x_position: 7, y_position: 7, color: "white")

    Piece.create(type: 'Knight',game_id: id, x_position: 1, y_position: 7, color: "white")
    Piece.create(type: 'Knight',game_id: id, x_position: 6, y_position: 7, color: "white")
    
    Piece.create(type: 'Bishop',game_id: id, x_position: 2, y_position: 7, color: "white")
    Piece.create(type: 'Bishop',game_id: id, x_position: 5, y_position: 7, color: "white")
    
    Piece.create(type: 'Queen',game_id: id, x_position: 3, y_position: 7, color: "white")
    Piece.create(type: 'King',game_id: id, x_position: 4, y_position: 7, color: "white")


  end

  
end

