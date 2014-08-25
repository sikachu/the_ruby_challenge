class CreateCodeChallenges < ActiveRecord::Migration
  def change
    create_table :code_challenges do |t|
      t.references :submitter, index: true, nil: false
      t.text :left_code_sample, nil: false
      t.text :right_code_sample, nil: false
      t.string :goal, nil: false

      t.timestamps
    end
  end
end
