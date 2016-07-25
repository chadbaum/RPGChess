# Main controller for chess session for CRUD
# logic for our app
class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  def index
  end

  def create
    @game = current_user.game.create(game_params)
  end

  def show
    @game = Game.new
  end

  def new
    @game = Game.new
  end

  private

  def game_params
    params.require(:game)
  end
end
