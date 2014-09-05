require "rails_helper"

describe CodeChallengesController do
  before { sign_in }

  describe "#create" do
    context "with valid attributes" do
      it "sets flash message and redirects user to #show" do
        post :create, code_challenge: attributes_for(:code_challenge)

        code_challenge = CodeChallenge.first
        expect(code_challenge).not_to be_nil
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to(code_challenge_path(code_challenge))
      end
    end

    context "with invalid attributes" do
      it "renders #new template" do
        post :create, code_challenge: {
          left_code_sample: "",
          right_code_sample: "",
          goal: ""
        }

        expect(response).to render_template(:new)
      end
    end
  end
end
