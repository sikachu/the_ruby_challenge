require "rails_helper"

describe User do
  describe ".find_or_create_by_authentication_hash" do
    context "when user with github_user_id does not exists" do
      it "creates user based on data from authentication hash" do
        user = User.find_or_create_by_authentication_hash(authentication_hash)

        expect(User.count).to eq 1
        expect(user.github_user_id).to eq "42"
        expect(user.github_username).to eq "sikachu"
        expect(user.access_token).to eq "123456abcdef"
        expect(user.name).to eq "Prem Sichanugrist"
        expect(user.email).to eq "sikachu@example.com"
        expect(user.avatar_url).to eq(
          "https://avatars.githubusercontent.com/u/42?v=2"
        )
      end
    end

    def authentication_hash
      {
        uid: "42",
        info: {
          email: "sikachu@example.com",
          nickname: "sikachu",
          name: "Prem Sichanugrist",
          image: "https://avatars.githubusercontent.com/u/42?v=2"
        },
        credentials: {
          token: "123456abcdef"
        }
      }
    end
  end
end
