require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:game) { FactoryGirl.create(:game, :populated) }

  let(:white_pawn) do
    game.pieces.find_by(
    type: 'Pawn',
    color: 'white',
    x_position: 7,
    y_position: 6
    )
  end

  let(:black_pawn) do
    game.pieces.find_by(
    type: 'White',
    color: 'black',
    x_position: 3,
    y_position: 3
    )
  end

  before(:each) do
    @player = game.players.create(color: 'black')
  end

  describe "player_turn" do
    it "should show first turn belong to white player" do
      @player.player_turn!

      expect(@player.color).to eq 'white'
    end

    it "should show 2nd turn belong to black player" do
      white_pawn.move!(7, 4)
      @player.player_turn!

      expect(@player.color).to eq 'black'
    end
  end
end
