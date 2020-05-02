class AddMoreDataToSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :airs_day_of_week, :string
    add_column :series, :airs_time, :string
    add_column :series, :runtime, :integer
  end
end
