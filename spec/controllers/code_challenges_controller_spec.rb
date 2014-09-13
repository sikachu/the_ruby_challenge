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

  describe "#show" do
    it "redirects to shorter slug when longer slug were provided" do
      create(:code_challenge, slug: "12345")

      get :show, id: "12345678"

      expect(response).to redirect_to(code_challenge_path("12345"))
    end

    it "does not redirect if shorter slug is not found" do
      expect { get :show, id: "12345678" }.
        to raise_error(ActiveRecord::RecordNotFound)
      expect(response).not_to redirect_to(code_challenge_path("12345"))
    end
  end
end
