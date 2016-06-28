class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :trailer
      t.text :description
      t.boolean :approved
      t.boolean :featured

      t.timestamps null: false
    end
  end
end
