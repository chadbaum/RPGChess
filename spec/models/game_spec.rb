require 'rails_helper'
require 'pry'

RSpec.describe Game, type: :model do
  describe 'populate the board' do
    let(:game) { FactoryGirl.create(:game, :populated) }

    it 'should give us 32 pieces upon board population' do
      expect(game.pieces.count).to eq 32
    end

    it 'should give me the last x position of population' do
      expect(game.pieces.last.x_position).to eq 7
    end

    it 'should give me the last y position of population' do
      expect(game.pieces.last.y_position).to eq 7
    end

    it 'should give me the last piece of the population as the King' do
      expect(game.pieces.last.type).to eq 'Rook'
    end

    it 'should give me the last pieces color' do
      expect(game.pieces.last.color).to eq 'white'
    end

    it 'should show first turn of game belong to white player' do
      expect(game.turn).to eq 'white'
    end

    it 'should show move number as 1' do
      expect(game.move_number).to eq 1
    end

    describe 'end_turn!' do
      it 'should increment move_number by 1 once the turn ended' do
        game.end_turn!

        expect(game.move_number).to eq 2
      end

      it 'should switch turn between black and white player' do
        game.end_turn!

        expect(game.turn).to eq 'black'
      end
    end
  end
end
