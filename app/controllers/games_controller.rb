class GamesController < ApplicationController
  layout "presentations"

  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
    redirect_to Game.create!
  end
end
