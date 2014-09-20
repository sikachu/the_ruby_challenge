class ChangeDisplayedToDisplayedAtOnCodeChallenges < ActiveRecord::Migration
  def change
    remove_column :code_challenges, :displayed, :boolean
    add_column :code_challenges, :displayed_at, :datetime
  end
end
