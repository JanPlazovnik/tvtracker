module ApplicationHelper
  def urlmagic(base, url)
    base = base.to_s
    url = url.to_s
    if url && url != ""
      if url == "/banners/images/missing/series.jpg"
        return "https://www.plazovnik.si/media/files/no_img.jpg"
      end
      return base + url
    else
      # base + "/banners/images/missing/series.jpg"
      return "https://www.plazovnik.si/media/files/no_img.jpg"
    end
  end
  def profileInitials
    current_user.first_name[0,1].upcase + current_user.last_name[0,1].upcase
  end
  def getWatchedText(episode)
    return "WATCHED!" if current_user.episodes.include?(episode)
    "WATCHED?"
  end
  def getWatchedClass(episode)
    return "watched" if current_user.episodes.include?(episode)
  end
  def whipUpEpisodeMeta(episode)
    str = "<span>"
    str += "#{episode.title} &middot; " if episode.title
    str += "Aired #{episode.date_aired.to_date }" if episode.date_aired
    str += "</span>"
    str += "<p>#{episode.summary}</p>"
    str.html_safe
  end
  def getAddedClass(id)
    return ["btn-add", "added"] if current_user.series.any? {|show| show.tvdb_id == id}
    ["btn-add"]
  end

end
