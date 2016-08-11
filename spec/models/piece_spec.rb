require 'rails_helper'

RSpec.describe Piece, type: :model do
  let(:game) { FactoryGirl.create(:game, :populated) }
  let(:queen) do
    game.pieces.find_by(
      type: 'Queen',
      color: 'white',
      x_position: 4,
      y_position: 7
    )
  end
  let(:moved_queen) do
    game.pieces.create(
      type: 'Queen',
      color: 'white',
      x_position: 3,
      y_position: 3,
      moved: true
    )
  end
  let(:white_pawn) do
    game.pieces.find_by(
      type: 'Pawn',
      color: 'white',
      x_position: 5,
      y_position: 6
    )
  end
  let(:black_pawn) do
    game.pieces.find_by(
      type: 'Pawn',
      color: 'black',
      x_position: 1,
      y_position: 1
    )
  end
  describe 'move with capture' do
    it 'should return true on move against a hostile piece' do
      victim = game.pieces.find_by(x_position: 3, y_position: 1)
      expect(moved_queen.move!(3, 1)).to eq true
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 1
      expect(moved_queen.moved).to eq true
      victim.reload
      expect(victim.x_position).to eq nil
      expect(victim.y_position).to eq nil
      expect(victim.captured).to eq true
    end

    it 'should return false on a move against a friendly piece' do
      victim = game.pieces.find_by(x_position: 3, y_position: 6)
      expect(moved_queen.move!(3, 6)).to eq false
      expect(moved_queen.x_position).to eq 3
      expect(moved_queen.y_position).to eq 3
      expect(moved_queen.moved).to eq true
      victim.reload
      expect(victim.x_position).to eq 3
      expect(victim.y_position).to eq 6
      expect(victim.captured).to eq false
    end

    it 'should false black piece move on the first turn' do
      expect(black_pawn.move!(1, 3)).to eq false
      expect(game.color).to eq 'white'
      expect(game.turn).to eq 1
    end

    it 'should return true if white piece move on the first turn' do
      expect(white_pawn.move!(5, 4)).to eq true
      expect(game.color).to eq 'black'
      expect(game.turn).to eq 2
    end

    it 'should return true if black piece move on the second turn' do
      white_pawn.move!(5, 4)

      expect(black_pawn.move!(1, 2)).to eq true
      expect(game.color).to eq 'white'
      expect(game.turn).to eq 3
    end
  end
end
