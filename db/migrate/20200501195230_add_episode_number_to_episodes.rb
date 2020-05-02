class AddEpisodeNumberToEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :episodes, :ep_number, :integer
    add_column :episodes, :date_aired, :timestamp
  end
end
