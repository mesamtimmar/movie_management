class AddColumnsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :duration, :integer
    add_column :movies, :genre, :string, limit: 50
    add_column :movies, :release_date, :date
  end
end
