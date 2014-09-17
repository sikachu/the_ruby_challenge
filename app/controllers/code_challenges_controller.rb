class CodeChallengesController < ApplicationController
  before_action :validate_user, except: :show
  before_action :redirect_to_shorter_slug, only: :show
  before_action :find_my_code_challenge, only: [:edit, :update, :destroy]

  def index
    @code_challenges = current_user.code_challenges.order(created_at: :desc)
  end

  def show
    @code_challenge = CodeChallenge.find_by_slug!(params[:id])
  end

  def new
    @code_challenge = current_user.code_challenges.build
  end

  def create
    @code_challenge = current_user.code_challenges.build(code_challenge_params)

    if @code_challenge.save
      flash[:success] = t(".created")
      redirect_to @code_challenge
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @code_challenge.update_attributes(code_challenge_params)
      flash[:success] = t(".updated")
      redirect_to @code_challenge
    else
      render :edit
    end
  end

  def destroy
    if @code_challenge.destroy
      flash[:alert] = t(".destroyed", slug: @code_challenge.slug)
    end

    redirect_to action: :index
  end

  private

  def code_challenge_params
    if current_user.admin?
      params.require(:code_challenge).permit(:goal, :left_code_sample,
        :right_code_sample, :left_time_usec, :right_time_usec)
    else
      params.require(:code_challenge).permit(:goal, :left_code_sample,
        :right_code_sample)
    end
  end

  def find_my_code_challenge
    @code_challenge = current_user.code_challenges.find_by_slug!(params[:id])
  end

  def redirect_to_shorter_slug
    if params[:id] && params[:id].size == 8
      if CodeChallenge.where(slug: params[:id].first(5)).exists?
        redirect_to id: params[:id].first(5), status: :moved_permanently
      end
    end
  end
end
