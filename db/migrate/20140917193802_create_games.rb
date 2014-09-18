class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :score, default: 0, null: false
      t.references :code_challenge_1
      t.references :code_challenge_2
      t.references :code_challenge_3
      t.references :code_challenge_4
      t.references :code_challenge_5

      t.timestamps
    end
  end
end
