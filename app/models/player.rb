# player Model
class Player < ApplicationRecord
  has_many :pieces
  belongs_to :game
  belongs_to :user

  validates :color, inclusion: { in: %w(black white) }

  def player_turn
    game.turn % 2 == 0 ? update(color: 'black') : update(color: 'white')  
  end

  def king
    piece_lookup('King')
  end

  def queen
    piece_lookup('Queen')
  end

  def rooks
    pieces_lookup('Rook')
  end

  def bishops
    pieces_lookup('Bishop')
  end

  def knights
    pieces_lookup('Knight')
  end

  def pawns
    pieces_lookup('Pawn')
  end

  private

  def piece_lookup(type)
    pieces.find_by(type: type)
  end

  def pieces_lookup(type)
    pieces.where(type: type)
  end
end
