require "rails_helper"

describe CodeChallenge do
  it { should belong_to(:submitter).class_name("User") }

  it { should validate_presence_of(:submitter) }
  it { should validate_presence_of(:left_code_sample) }
  it { should validate_presence_of(:right_code_sample) }
  it { should ensure_inclusion_of(:goal).in_array(CodeChallenge::GOALS) }

  describe ".create" do
    it "generates unique slug" do
      code_challenge = create(:code_challenge)

      expect(code_challenge.slug).not_to be_nil
      expect(code_challenge.slug.size).to eq 5
    end

    it "retries slug generation when slug already exists" do
      create(:code_challenge, slug: "12345678")
      new_code_challenge = create(:code_challenge, slug: "12345678")

      expect(new_code_challenge.slug).not_to eq("12345678")
    end
  end

  describe "#to_param" do
    it "returns slug" do
      code_challenge = CodeChallenge.new.tap(&:valid?)

      expect(code_challenge.to_param).to eq code_challenge.slug
    end
  end
end
