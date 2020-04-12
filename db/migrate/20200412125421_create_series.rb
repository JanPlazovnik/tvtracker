class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series do |t|
      t.string :title, null: false, default: ""
      t.text :summary, null: false, default: ""
      t.timestamps
    end
  end
end
