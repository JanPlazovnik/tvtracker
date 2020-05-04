class EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_episode, only: [:show, :watch]

  # GET /episodes/1
  # GET /episodes/1.json
  def show
    @comment = @episode.comments.build
    @comments = @episode.comments.all.order(created_at: :desc)
  end

  def watch
    return current_user.episodes.delete(@episode) if current_user.episodes.include?(@episode)
    show = Series.find(@episode.season.series_id)
    unless current_user.series.include?(show)
      p "user hasn't added the show to their list yet"
      current_user.series << show
    end
    p "marking episode as watched"
    current_user.episodes << @episode 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def episode_params
      params.fetch(:episode, {})
    end
end
