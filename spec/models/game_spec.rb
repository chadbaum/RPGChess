require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:empty_game) { FactoryGirl.create(:game) }
  let(:game) { FactoryGirl.create(:game, :populated) }

  describe 'game creation and population' do
    it 'should return 32 pieces for a game upon populating' do
      expect(game.pieces.count).to eq 32
    end
  end
end
