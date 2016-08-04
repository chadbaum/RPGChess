require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'games#index' do
    it 'should successfully load the homepage' do
      get :index, method: :post
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#new' do
    it 'should show the new game form if the user is signed in' do
      user = FactoryGirl.create(:user)
      sign_in user

      get :new, method: :post
      expect(response).to have_http_status(:success)
    end
    it 'should redirect user to sign_in page if they are not signed_in' do
      process :create, method: :post, game: { turn: nil }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'games#create' do
    it 'should create a new game in the database' do
      process :create, method: :post, game: { turn: nil }
    end
  end

  # UPDATE #
  describe 'games#update' do
    let(:game) { FactoryGirl.create(:game) }
    it 'should update the coords of the White Pawn if the move coords are valid' do

      white_pawn = game.pieces.find_by(
        type: 'Pawn',
        color: 'white',
        x_position: 7,
        y_position: 6
      )

      patch :update, id: game.id, game: { id: white_pawn.id, piece: {x_position: 7, y_position: 5 } }

      expect(response).to have_http_status(:success)
      # expect(white_pawn.move!(7, 7)).to eq false
      white_pawn.reload
      expect(white_pawn.x_position).to eq(7)
      expect(white_pawn.y_position).to eq(5)
    end

    it 'should update the coords of the Black Knight the move coords are valid' do

      black_knight = game.pieces.find_by(
        type: 'Knight',
        color: 'black',
        x_position: 1,
        y_position: 0
      )

      patch :update, method: :update, params: { id: 1, piece_id: 2, x_position: 0, y_position: 2 }

      expect(response).to have_http_status(:success)
      # expect(black_knight.move!(0, 2)).to eq true
      black_knight.reload
      expect(black_knight.x_position).to eq(0)
      expect(black_knight.y_position).to eq(2)
    end


    # it 'should update the coords of the Black Rook the move coords are valid' do

    #   black_rook = game.pieces.find_by(
    #     type: 'Rook',
    #     color: 'black',
    #     x_position: 0,
    #     y_position: 0
    #   )

    #   patch :update, method: :update, params: { id: 1, piece_id: 1, x_position: 0, y_position: 1 }

    #   expect(response).to have_http_status(:success)
    #   expect(black_rook.move!(0, 1)).to eq true
    #   black_rook.reload
    #   expect(black_rook.x_position).to eq(7)
    #   expect(black_rook.y_position).to eq(5)
    # end

  end
end
