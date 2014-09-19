class AddDefaultGoalToCodeChallenges < ActiveRecord::Migration
  def up
    change_column_default :code_challenges, :goal, "speed"
  end

  def down
    change_column_default :code_challenges, :goal, nil
  end
end
