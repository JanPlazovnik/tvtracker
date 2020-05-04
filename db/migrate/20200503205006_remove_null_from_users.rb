class RemoveNullFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :series, :title, :string, :null => true, :default => "Untitled"
    change_column :episodes, :title, :string, :null => true, :default => "Untitled"
    change_column :series, :summary, :text, :null => true, :default => "No description available"
  end
end
