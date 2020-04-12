class SeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_series, only: [:show]

  def index
    @series = Series.search(params[:q])
  end

  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_series
    @series = Series.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def series_params
    params.fetch(:series, :q, {})
  end
end
