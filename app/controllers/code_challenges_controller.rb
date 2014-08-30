class CodeChallengesController < ApplicationController
  before_action :validate_user

  def show
    @code_challenge = CodeChallenge.find(params[:id])
  end

  def new
    @code_challenge = CodeChallenge.new
  end

  def create
    @code_challenge = CodeChallenge.new(code_challenge_params)

    if @code_challenge.save
      redirect_to @code_challenge, notice: t(".created")
    else
      render :new
    end
  end

  private

  def code_challenge_params
    params.require(:code_challenge).permit(:goal, :left_code_sample,
      :right_code_sample).merge(:submitter => current_user)
  end
end
