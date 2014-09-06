class CodeChallengesController < ApplicationController
  before_action :validate_user, except: :show

  def index
    @code_challenges = CodeChallenge.all
  end

  def show
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])
  end

  def new
    @code_challenge = CodeChallenge.new
  end

  def create
    @code_challenge = CodeChallenge.new(code_challenge_params)

    if @code_challenge.save
      flash[:success] = t(".created")
      redirect_to @code_challenge
    else
      render :new
    end
  end

  def edit
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])
  end

  def update
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])

    if @code_challenge.update_attributes(code_challenge_params)
      flash[:success] = t(".updated")
      redirect_to @code_challenge
    else
      render :edit
    end
  end

  def destroy
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])

    if @code_challenge.destroy
      flash[:alert] = t(".destroyed", slug: @code_challenge.slug)
    end

    redirect_to action: :index
  end

  private

  def code_challenge_params
    params.require(:code_challenge).permit(:goal, :left_code_sample,
      :right_code_sample).merge(:submitter => current_user)
  end
end
