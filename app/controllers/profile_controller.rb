class ProfileController < ApplicationController
  # before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def show
    # @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
