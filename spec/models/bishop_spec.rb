require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe "white bishop movement validation" do

    it "should return false if the bishop is not being moved from its original location" do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(7,2)).to eq false
    end

    it "should return false if the bishop is moved 2 spaces to the left" do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(7,0)).to eq false
    end

    it "should return false if the bishop is moved forwards one space" do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(6,2)).to eq false
    end

    it "should return true if the bishop 3 spaces diagonally forward and to the right" do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(4,5)).to eq true
    end

    it "should return true if the bishop 2 spaces diagonally forward and to the left" do
      bishop = FactoryGirl.create(:bishop)
      expect(bishop.valid_move?(5,0)).to eq true
    end

  end
end
