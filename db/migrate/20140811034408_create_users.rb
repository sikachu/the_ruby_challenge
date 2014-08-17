class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_user_id, null: false
      t.string :github_username, null: false
      t.string :access_token, null: false
      t.string :name
      t.string :email
      t.string :avatar_url

      t.timestamps

      t.index :github_user_id, :unique => true
      t.index :github_username, :unique => true
    end
  end
end
