class AddLeftTimeAndRightTimeToCodeChallenges < ActiveRecord::Migration
  def change
    add_column :code_challenges, :left_time_usec, :integer
    add_column :code_challenges, :right_time_usec, :integer
  end
end
