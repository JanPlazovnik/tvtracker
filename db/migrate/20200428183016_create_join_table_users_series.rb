class CreateJoinTableUsersSeries < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :series do |t|
      t.index :user_id
      t.index :series_id
    end
  end
end
