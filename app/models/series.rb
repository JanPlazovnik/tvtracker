class Series < ApplicationRecord
  #   require "excon"
  def self.search(query)
    if query
      response = Excon.get("https://api.thetvdb.com/search/series?name=#{query}", :headers => { "Authorization" => "Bearer #{self.fetch_token}" })
      return nil if response.status != 200
      JSON.parse(response.body)["data"]
    else
      all
    end
  end

  def self.fetch_token
    Rails.cache.fetch("#{cache_versioning}/token", expires_in: 23.hours) do
      puts "i'm doing this"
      response = Excon.post("https://api.thetvdb.com/login", :body => { "apiKey": "41e4c0a69d45a053ee330b255c16f5f5", "userKey": "5E41D7E615E9D3.01108714", "password": "plazovnik123tvdb" }.to_json, :headers => { "Content-Type" => "application/json" })
      JSON.parse(response.body)["token"]
    end
  end
end
