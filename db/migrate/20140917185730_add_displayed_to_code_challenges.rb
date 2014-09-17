class AddDisplayedToCodeChallenges < ActiveRecord::Migration
  def change
    add_column :code_challenges, :displayed, :boolean, default: false, null: false
  end
end
