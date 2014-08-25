require "rails_helper"

describe CodeChallenge do
  it { should belong_to(:submitter).class_name("User") }

  it { should validate_presence_of(:submitter) }
  it { should validate_presence_of(:left_code_sample) }
  it { should validate_presence_of(:right_code_sample) }
  it { should ensure_inclusion_of(:goal).in_array(CodeChallenge::GOALS) }
end
