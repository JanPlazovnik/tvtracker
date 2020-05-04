class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def show
    # @user = current_user
  end

  def recent
    # maybe it's okay
    @comments = current_user.comments.order("created_at desc").limit(6)
    @episodes = current_user.episodes.order("created_at desc").limit(10)
    @series = current_user.series.order("created_at desc").limit(5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
