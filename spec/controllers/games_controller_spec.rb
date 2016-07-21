require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#index' do
    it 'should successfully load the homepage' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    game = FactoryGirl.create(:game)
    it 'should redirect non-signed_in user if they attempt to create game' do
      game = Game.last
      expect(response).to redirect_to new_user_session_path
    end
    it 'should only allow signed-in users to create a game' do
      user = FactoryGirl.create(:user)
      sign_in user

      game = Game.last
    end
  end
end
