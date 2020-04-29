class AddImageAndStatusToSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :tvdb_id, :integer
    add_column :series, :image, :string
    add_column :series, :status, :string
    add_column :series, :first_aired, :timestamp
  end
end
