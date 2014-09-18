class Game < ActiveRecord::Base
  belongs_to :code_challenge_1, class_name: "CodeChallenge"
  belongs_to :code_challenge_2, class_name: "CodeChallenge"
  belongs_to :code_challenge_3, class_name: "CodeChallenge"
  belongs_to :code_challenge_4, class_name: "CodeChallenge"
  belongs_to :code_challenge_5, class_name: "CodeChallenge"

  before_create :assign_unused_code_challenges

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
