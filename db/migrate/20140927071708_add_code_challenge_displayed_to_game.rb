class AddCodeChallengeDisplayedToGame < ActiveRecord::Migration
  def change
    add_column :games, :code_challenge_1_displayed, :boolean, default: false
    add_column :games, :code_challenge_2_displayed, :boolean, default: false
    add_column :games, :code_challenge_3_displayed, :boolean, default: false
    add_column :games, :code_challenge_4_displayed, :boolean, default: false
    add_column :games, :code_challenge_5_displayed, :boolean, default: false
  end
end
