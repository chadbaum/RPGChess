require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe "white knight movement validation" do

    it "should return false if the knight is not being moved from its original location" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(7,1)).to eq false
    end

    it "should return false if the knight is moved 2 spaces to the right" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(7,3)).to eq false
    end

    it "should return false if the knight is moved forwards one space" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(6,1)).to eq false
    end

    it "should return false if the knight 3 spaces diagonally forward and to the right" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(4,4)).to eq false
    end

    it "should return true if the knight moves forward 2 spaces and then 1 space to the left" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(5,2)).to eq true
    end

    it "should return true if the knight moves to the right 2 spaces and then 1 space forward" do
      knight = FactoryGirl.create(:knight, :white)
      expect(knight.valid_move?(6,3)).to eq true
    end

  end

  describe "black knight movement validation" do

    it "should return false if the knight is not being moved from its original location" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(0,1)).to eq false
    end

    it "should return false if the knight is moved 2 spaces to the right" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(0,3)).to eq false
    end

    it "should return false if the knight is moved forwards one space" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(1,1)).to eq false
    end

    it "should return false if the knight 3 spaces diagonally forward and to the right" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(3,4)).to eq false
    end

    it "should return true if the knight moves forward 2 spaces and then 1 space to the left" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(2,0)).to eq true
    end

    it "should return true if the knight moves to the right 2 spaces and then 1 space forward" do
      knight = FactoryGirl.create(:knight, :black)
      expect(knight.valid_move?(1,3)).to eq true
    end

  end
end
