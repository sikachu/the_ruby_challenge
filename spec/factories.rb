FactoryGirl.define do
  factory :user do
    sequence(:github_user_id) { |n| n.to_s }
    sequence(:github_username) { |n| "user#{n}" }
    access_token { SecureRandom.hex }
    name { github_username.capitalize }
    email { "#{github_username}@example.com" }

    avatar_url do
      "https://avatars.githubusercontent.com/u/#{github_user_id}?v=2"
    end
  end
end
