class CodeChallenge < ActiveRecord::Base
  GOALS = %w(speed memory_usage)

  belongs_to :submitter, class_name: "User"

  validates :submitter, :left_code_sample, :right_code_sample, presence: :true
  validates :goal, inclusion: GOALS
end
