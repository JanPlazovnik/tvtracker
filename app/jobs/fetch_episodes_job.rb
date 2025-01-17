
class FetchEpisodesJob < ApplicationJob
  queue_as :default

  def perform(id, cancelIfEpisodesExists)
    p id
    response = fetch(id, 1)
    if response.status != 200
      p response.status
      p "error 1"
    else
      pages = JSON.parse(response.body)["links"]["last"]
      series = Series.where(tvdb_id: id)
      return if cancelIfEpisodesExists && series.first.seasons.count > 0
      # fetch extra series data
      showData = fetchSeriesInfo(id)
      sds = showData.status
      parsedShowData = JSON.parse(showData.body)["data"] if sds == 200
      ActiveRecord::Base.transaction do
        # i know that this is shit, and yes, i know how to make it better, i just don't have the time to do that rn.. but don't lose hope, maybe one day i'll improve it. maybe!
        p parsedShowData
        series.update(airs_day_of_week: parsedShowData["airsDayOfWeek"]) if parsedShowData["airsDayOfWeek"].present? 
        series.update(airs_time: parsedShowData["airsTime"]) if parsedShowData["airsTime"].present? 
        series.update(runtime: parsedShowData["runtime"]) if parsedShowData["runtime"].present? 
        for i in 1..pages
          # p "Page #{i}"
          # p "Fetching episodes for id: #{id} on page: #{i}"
          response2 = fetch(id, i)
          # p "Got response" if response2.status == 200
          if response2.status == 200
            # p "Parsing the response body."
            results = JSON.parse(response2.body)["data"]
            # p "Body parsed"
            # p "Iterating the episodes on page #{i}"
            results.each do |episode|
              # p "Season: #{episode["airedSeason"]}, Episode: #{episode["airedEpisodeNumber"]}"
              now = Time.now
              season_row = { number: episode["airedSeason"], tvdb_season_id: episode["airedSeasonID"], series_id: series[0].id, created_at: now, updated_at: now }
              season = Season.upsert(season_row, unique_by: [:tvdb_season_id]).to_a

              now = Time.now
              #  date_aired: DateTime.parse(episode["firstAired"])
              # p episode["firstAired"].present?
              if episode["firstAired"].present?
                # p DateTime.parse(episode["firstAired"])
                episode_row = { title: episode["episodeName"], summary: episode["overview"], tvdb_episode_id: episode["id"], date_aired: DateTime.parse(episode["firstAired"]), season_id: season[0]["id"], ep_number: episode["dvdEpisodeNumber"], created_at: now, updated_at: now }
              else 
                episode_row = { title: episode["episodeName"], summary: episode["overview"], tvdb_episode_id: episode["id"], season_id: season[0]["id"], ep_number: episode["dvdEpisodeNumber"], created_at: now, updated_at: now }
              end
              Episode.upsert(episode_row, unique_by: [:tvdb_episode_id])
            end
          else
            p results.status
            p "error 2"
          end
        end
      end
    end
  end

  private

  def fetch(id, page)
    return Excon.get("https://api.thetvdb.com/series/#{id}/episodes?page=#{page}", :headers => { "Authorization" => "Bearer #{Series.fetch_token}" })
  end
  def fetchSeriesInfo(id)
    return Excon.get("https://api.thetvdb.com/series/#{id}", :headers => { "Authorization" => "Bearer #{Series.fetch_token}" })
  end
end