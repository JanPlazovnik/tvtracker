class CreateJoinTableUsersEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :episodes do |t|
      t.index [:user_id, :episode_id]
      t.index [:episode_id, :user_id]
    end
  end
end
