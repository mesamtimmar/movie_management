class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
