require 'rails_helper'

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
  end
end
