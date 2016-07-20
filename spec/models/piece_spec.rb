require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'moved flag for piece' do
    it 'should return false if piece has never moved' do
      bishop = FactoryGirl.create(:bishop, :white)
      expect(bishop.moved).to eq false
    end

    it 'should return true if piece has moved' do
      bishop = FactoryGirl.create(:bishop, :white)
      bishop.move!(3, 6)
      expect(bishop.moved).to eq true
    end
  end
end
