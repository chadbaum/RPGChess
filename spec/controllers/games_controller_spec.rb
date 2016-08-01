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

  describe 'games#update' do
    it 'should update the coords of the white pawn in the database' do
      game = FactoryGirl.create(:game)
      # test not working currently, something is wrong with its params. To be fixed.
      patch :update, id: game.id, game: { piece_id: 24, x_position: 7, y_position: 5 }

      piece = game.pieces.find_by_id(24)
      piece_x_pos = piece.x_position
      piece_y_pos = piece.y_position
      expect(response).to have_http_status(:success)
      expect(piece_x_pos).to eq(7)
      expect(piece_y_pos).to eq(5)
    end
  end
end
