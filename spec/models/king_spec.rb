require 'rails_helper'

RSpec.describe King, type: :model do
  let(:test_game) { FactoryGirl.create(:game) }
  let(:king) { test_game.white.king }

  describe 'creation' do
    it 'should create a white king' do
      king = FactoryGirl.create(:king, color: 'white')
      expect(king.type).to eq('King')
    end

    it 'should fail to create a red king' do
      expect { FactoryGirl.create(:king, color: 'red') }.to\
        raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'moved' do
    it 'should return false if not moved' do
      expect(king.move!(4, 7)).to eq false
      expect(king.x_position).to eq 4
      expect(king.y_position).to eq 7
      expect(king.moved).to eq false
    end
  end

  describe 'invalid moveset' do
    it 'should return false and not update position on invalid move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(1, 4)).to eq false
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 3
      expect(king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(7, 3)).to eq false
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 3
      expect(king.moved).to eq true
    end

    it 'should return false and not update position on invalid move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(5, 5)).to eq false
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 3
      expect(king.moved).to eq true
    end
  end

  describe 'non-obstructed move' do
    it 'should return true and update position on non-obstructed move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(3, 4)).to eq true
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 4
      expect(king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(2, 4)).to eq true
      expect(king.x_position).to eq 2
      expect(king.y_position).to eq 4
      expect(king.moved).to eq true
    end

    it 'should return true and update position on non-obstructed move' do
      king.update(x_position: 3, y_position: 3, moved: true)
      expect(king.move!(3, 4)).to eq true
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 4
      expect(king.moved).to eq true
    end
  end

  describe 'castling' do
    it 'should return true on valid white king-side castling' do
      white_castling_rook.save
      expect(white_castling_king.move!(6, 7)).to eq true
      expect(white_castling_king.x_position).to eq 6
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq true
      white_castling_rook.reload
      expect(white_castling_rook.x_position).to eq 5
      expect(white_castling_rook.y_position).to eq 7
      expect(white_castling_rook.moved).to eq true
    end

    it 'should return true on valid black king-side castling' do
      black_castling_rook.save
      expect(black_castling_king.move!(6, 0)).to eq true
      expect(black_castling_king.x_position).to eq 6
      expect(black_castling_king.y_position).to eq 0
      expect(black_castling_king.moved).to eq true
      black_castling_rook.reload
      expect(black_castling_rook.x_position).to eq 5
      expect(black_castling_rook.y_position).to eq 0
      expect(black_castling_rook.moved).to eq true
    end

    it 'should return false on obstructed white queen-side castling' do
      white_obstructed_rook.save
      white_obstruction.save
      expect(white_castling_king.move!(2, 7)).to eq false
      expect(white_castling_king.x_position).to eq 4
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq false
      expect(white_obstructed_rook.x_position).to eq 0
      expect(white_obstructed_rook.y_position).to eq 7
      expect(white_obstructed_rook.moved).to eq false
    end

    it 'should return false on obstructed black queen-side castling' do
      black_obstructed_rook.save
      black_obstruction.save
      expect(black_castling_king.move!(2, 0)).to eq false
      expect(black_castling_king.x_position).to eq 4
      expect(black_castling_king.y_position).to eq 0
      expect(black_castling_king.moved).to eq false
      expect(black_obstructed_rook.x_position).to eq 0
      expect(black_obstructed_rook.y_position).to eq 0
      expect(black_obstructed_rook.moved).to eq false
    end

    it 'should return false on castling when rook moved' do
      white_castling_rook.update(moved: true)
      expect(white_castling_king.move!(6, 7)).to eq false
      expect(white_castling_king.x_position).to eq 4
      expect(white_castling_king.y_position).to eq 7
      expect(white_castling_king.moved).to eq false
      expect(white_castling_rook.x_position).to eq 7
      expect(white_castling_rook.y_position).to eq 7
      expect(white_castling_rook.moved).to eq true
    end
  end
end
