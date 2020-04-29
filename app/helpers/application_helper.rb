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
end
