require 'rails_helper'

RSpec.describe King, type: :model do

  describe "white king movement validation" do

    it "should return false if the king is not being moved from its original location" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(3,7)).to eq false
    end

    it "should return false if the king moves 2 spaces to the right" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(5,7)).to eq false
    end

    it "should return false if the king moves 3 spaces diagonally forward and to the right" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(6,4)).to eq false
    end

    it "should return true if the king moves forward and to the right 1 space" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(4,6)).to eq true
    end

    it "should return true if the king moves to the left 1 space" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(2,7)).to eq true
    end

    it "should return true if the king moves forward 1 space" do
      king = FactoryGirl.create(:king, :white)
      expect(king.valid_move?(3,6)).to eq true
    end

  end

  describe "black king movement validation" do

    it "should return false if the king is not being moved from its original location" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(3,0)).to eq false
    end

    it "should return false if the king moves 2 spaces to the right" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(5,0)).to eq false
    end

    it "should return false if the king moves 3 spaces diagonally forward and to the right" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(6,3)).to eq false
    end

    it "should return true if the king moves forward and to the right 1 space" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(4,1)).to eq true
    end

    it "should return true if the king moves to the left 1 space" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(2,0)).to eq true
    end

    it "should return true if the king moves forward 1 space" do
      king = FactoryGirl.create(:king, :black)
      expect(king.valid_move?(3,1)).to eq true
    end
  end

  describe "king creation validation" do

    it "should have a type of King" do
      r = FactoryGirl.create(:king, color: 'white')
      expect(r.type).to eq("King")
    end

    it "should not be allowed to create a red king" do
      expect { FactoryGirl.create(:king, color: "red") }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "king move method" do

    it "should return 'valid' and update the king's position when it makes a valid move" do
      king = FactoryGirl.create(:king, :white)
      expect(king.move(4,6)).to eq "valid"
      expect(king.x_position).to eq 4
      expect(king.y_position).to eq 6
    end

    it "should return 'nil' and not update the king's position when it makes an invalid move" do
      king = FactoryGirl.create(:king, :black)
      expect(king.move(5,0)).to eq nil
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 0
    end

  end

end
