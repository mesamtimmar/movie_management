class AddValidationsToActors < ActiveRecord::Migration
  def up
    change_column :actors, :name, :string, limit: 50, null: false
    change_column :actors, :gender, :string, limit: 10, null: false
  end

  def down
    change_column :actors, :name, :string, limit: 255, null: true
    change_column :actors, :gender, :string, limit: 255, null: true
  end
end
