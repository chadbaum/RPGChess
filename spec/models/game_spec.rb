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

  let(:empty_game) { FactoryGirl.create(:game) }
  let(:king) do
    empty_game.pieces.create(
      type: 'King',
      color: 'black',
      x_position: 3,
      y_position: 4,
      moved: true
    )
  end

  let(:rook) do
    empty_game.pieces.create(
      type: 'Rook',
      color: 'white',
      x_position: 0,
      y_position: 5,
      moved: true
    )
  end

  describe 'check?' do
    it "should return false if king is not under check" do
      expect(rook.move!(0, 3)).to eq true
      rook.move!(0, 3)
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 3
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 4
      expect(king.moved).to eq true
      expect(rook.moved).to eq true
      k = game.pieces.find_by(
            type: 'King',
            color: 'black'
          )
      expect(k.id).to eq 5
      game.pieces.destroy(k.id)
      # expect(game.pieces.count).to eq 32
      # expect(k.x_position).to eq 4
      # expect(k.y_position).to eq 4
      expect(king.checked?).to eq false
    end
    it 'should return true if black or white king is under check' do
      expect(rook.move!(0, 4)).to eq true
      rook.move!(0, 4)
      expect(rook.x_position).to eq 0
      expect(rook.y_position).to eq 4
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 4
      expect(rook.moved).to eq true
      expect(king.checked?).to eq true
    end


  end

end
