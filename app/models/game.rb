class Game < ActiveRecord::Base
  belongs_to :code_challenge_1, class_name: "CodeChallenge"
  belongs_to :code_challenge_2, class_name: "CodeChallenge"
  belongs_to :code_challenge_3, class_name: "CodeChallenge"
  belongs_to :code_challenge_4, class_name: "CodeChallenge"
  belongs_to :code_challenge_5, class_name: "CodeChallenge"

  before_create :assign_unused_code_challenges

  def mark_code_challenge_as_displayed(code_challenge)
    case code_challenge
    when code_challenge_1
      update_column :code_challenge_1_displayed, true
    when code_challenge_2
      update_column :code_challenge_2_displayed, true
    when code_challenge_3
      update_column :code_challenge_3_displayed, true
    when code_challenge_4
      update_column :code_challenge_4_displayed, true
    when code_challenge_5
      update_column :code_challenge_5_displayed, true
    end
  end

  private

  def assign_unused_code_challenges
    code_challenges = CodeChallenge.random.unused.limit(5)
    self.code_challenge_1 = code_challenges[0]
    self.code_challenge_2 = code_challenges[1]
    self.code_challenge_3 = code_challenges[2]
    self.code_challenge_4 = code_challenges[3]
    self.code_challenge_5 = code_challenges[4]
  end
end
