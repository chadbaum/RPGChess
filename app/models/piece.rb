class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  validates :color, inclusion: { in: %w(black white) }
  validates :type, inclusion: { in: %w(Pawn Rook Bishop Knight King Queen) }

end

# Sample piece creation - Piece.create(type:"Queen", color:"white") type must be capitalized.
                      # - Rook.create(color:"white")