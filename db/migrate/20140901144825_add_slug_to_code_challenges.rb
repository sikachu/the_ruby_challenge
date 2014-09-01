class AddSlugToCodeChallenges < ActiveRecord::Migration
  def change
    add_column :code_challenges, :slug, :string, null: false
    add_index :code_challenges, :slug, unique: true
  end
end
