class AddValidationsToUsers < ActiveRecord::Migration
  def up
    change_column :users, :full_name, :string, limit: 50, null: false
    change_column :users, :email, :string, limit: 100, default: "", null: false
    change_column :users, :unconfirmed_email, :string, limit: 100
  end

  def down
    change_column :users, :full_name, :string, limit: 255, null: true
    change_column :users, :email, :string, limit: 255, default: "", null:false
    change_column :users, :unconfirmed_email, :string, limit: 255
  end
end
