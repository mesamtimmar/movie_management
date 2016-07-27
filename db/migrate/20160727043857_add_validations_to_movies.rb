class AddValidationsToMovies < ActiveRecord::Migration
  def up
    change_column :movies, :title, :string, limit: 150, null: false
    change_column :movies, :trailer, :string, null: false
    change_column :movies, :description, :text, null: false
    change_column :movies, :genre, :string, limit: 50, null: false
  end

  def down
    change_column :movies, :title, :string
    change_column :movies, :trailer, :string
    change_column :movies, :description, :text
    change_column :movies, :genre, :string, limit: 50
  end
end
