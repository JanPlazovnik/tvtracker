class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :title, null: true, default: ""
      t.text :summary, null: true, default: ""

      t.belongs_to :season

      t.integer :tvdb_episode_id, null: false, default: 0, index: { unique: true }

      t.timestamps
    end
    # add_reference :episodes, :season, foreign_key: true
  end
end
