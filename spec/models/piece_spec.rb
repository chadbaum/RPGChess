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
  end

  # let(:king) do
  #   game.pieces.find_by(
  #     type: 'King',
  #     color: 'white'
  #   )
  # end

  # let(:moved_king) do
  #   game.pieces.create(
  #     type: 'King',
  #     color: 'black',
  #     x_position: 3,
  #     y_position: 4,
  #     moved: true
  #   )
  # end

  # let(:rook) do
  #   game.pieces.create(
  #     type: 'Rook',
  #     color: 'white',
  #     x_position: 0,
  #     y_position: 5,
  #     moved: true
  #   )
  # end

  # describe 'state of check' do
  #   it 'should return true if black or white king is under check' do
  #     expect(rook.move!(0, 4)).to eq true
  #     expect(rook.x_position).to eq 0
  #     expect(rook.y_position).to eq 4
  #     expect(rook.moved).to eq true
  #     expect(moved_king.checked?).to eq true
  #   end
  #   it "should return false if king is not under check" do

  #     expect(rook.move!(0, 4)).to eq true
  #     expect(rook.x_position).to eq 0
  #     expect(rook.y_position).to eq 4
  #     expect(rook.moved).to eq true
  #     expect(king.checked?).to eq false
  #   end

  # end


end
