require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe "white queen movement validation" do

    it "should return false if the queen is not being moved from its original location" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(7,4)).to eq false
    end

    it "should return false if the queen moves forward 2 spaces and then 1 space to the left" do
      knight = FactoryGirl.create(:queen, :white)
      expect(knight.valid_move?(5,3)).to eq false
    end

    it "should return true if the queen moves 2 spaces to the right" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(7,6)).to eq true
    end

    it "should return true if the queen moves 3 spaces diagonally forward and to the right" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(4,7)).to eq true
    end

    it "should return true if the queen moves forward and to the right 1 space" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(6,5)).to eq true
    end

    it "should return true if the queen moves to the left 1 space" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(7,3)).to eq true
    end

    it "should return true if the queen moves forward 1 space" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(6,4)).to eq true
    end

    it "should return true if the queen moves forward 5 spaces" do
      queen = FactoryGirl.create(:queen, :white)
      expect(queen.valid_move?(2,4)).to eq true
    end

  end

  describe "black queen movement validation" do

    it "should return false if the queen is not being moved from its original location" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(0,4)).to eq false
    end

    it "should return false if the queen moves forward 2 spaces and then 1 space to the left" do
      knight = FactoryGirl.create(:queen, :black)
      expect(knight.valid_move?(2,3)).to eq false
    end

    it "should return true if the queen moves 2 spaces to the right" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(0,6)).to eq true
    end

    it "should return true if the queen moves 3 spaces diagonally forward and to the right" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(3,7)).to eq true
    end

    it "should return true if the queen moves forward and to the right 1 space" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(1,5)).to eq true
    end

    it "should return true if the queen moves to the left 1 space" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(0,3)).to eq true
    end

    it "should return true if the queen moves forward 1 space" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(1,4)).to eq true
    end

    it "should return true if the queen moves forward 5 spaces" do
      queen = FactoryGirl.create(:queen, :black)
      expect(queen.valid_move?(5,4)).to eq true
    end

  end
end
