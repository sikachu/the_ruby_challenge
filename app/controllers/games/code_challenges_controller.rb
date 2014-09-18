class Games::CodeChallengesController < ApplicationController
  layout "presentations"

  before_action :load_game_and_code_challenge

  def show
  end

  def update
    @code_challenge.pick(params[:side])

    if @code_challenge.correct?
      @game.increment!(:score)
    end
  end

  private

  def load_game_and_code_challenge
    @game = Game.find(params[:game_id])
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])
  end
end
