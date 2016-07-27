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
end
