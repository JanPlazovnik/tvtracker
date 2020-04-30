class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.integer :number, null: false, default: 0
      t.belongs_to :series
      t.integer :tvdb_season_id, null: false, default: 0, index: { unique: true }

      t.timestamps
    end
    # add_reference :seasons, :serie, foreign_key: true
  end
end
