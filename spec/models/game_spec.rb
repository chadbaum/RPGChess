require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate the board' do
    it 'should give us 32 pieces upon board population' do
      g = FactoryGirl.create(:game)
      expect(g.pieces.count).to eq 32
    end
    it 'should give me the last x position of population' do
      g = FactoryGirl.create(:game)
      expect(g.pieces.last.x_position).to eq 4
    end
    it 'should give me the last y position of population' do
      g = FactoryGirl.create(:game)
      expect(g.pieces.last.y_position).to eq 0
    end
    it 'should give me the last piece of the population as the King' do
      g = FactoryGirl.create(:game)
      expect(g.pieces.last.type).to eq 'King'
    end
    it 'should give me the last pieces color' do
      g = FactoryGirl.create(:game)
      expect(g.pieces.last.color).to eq 'black'
    end
  end
end
