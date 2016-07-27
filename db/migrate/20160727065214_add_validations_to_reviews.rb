class AddValidationsToReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :comment, :text, null: false
    change_column :reviews, :user_id, :integer, null: false
    change_column :reviews, :movie_id, :integer, null: false
  end

  def down
    change_column :reviews, :comment, :text, null: true
    change_column :reviews, :user_id, :integer, null: true
    change_column :reviews, :movie_id, :integer, null: true
  end
end
