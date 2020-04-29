class SeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_series, only: [:show]

  def index
    results = Series.search(params[:q])
    @series = Array.new
    results.each do |show|
      stored = Series.where(tvdb_id: show["id"])
      if stored.present?
        @series << {
          :tvdb_id => stored[0].tvdb_id,
          :title => stored[0].title.to_s,
          :summary => stored[0].summary,
          :image => stored[0].image,
          :first_aired => stored[0].first_aired,
          :status => stored[0].status,
          :stored => true,
        }
      else
        @series << {
          :tvdb_id => show["id"],
          :title => show["seriesName"],
          :summary => show["overview"],
          :image => show["image"],
          :first_aired => show["firstAired"],
          :status => show["status"],
        }
      end
    end
  end

  def show
  end

  def add
    if params["stored"]
      if current_user.series.where(tvdb_id: params["tvdb_id"])
        p "found one"
      else
        p "nope"
      end
    else
      series = Series.new
      series.tvdb_id = params["tvdb_id"]
      series.title = params["title"]
      series.summary = params["summary"]
      series.image = params["image"]
      series.first_aired = DateTime.parse(params["first_aired"])
      series.status = params["status"]
      series.save
      current_user.series << series
      current_user.save
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_series
    @series = Series.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def series_params
    params.fetch(:series, :q, :test, {})
  end
end
