class User < ActiveRecord::Base
  has_many :code_challenges, foreign_key: :submitter_id

  def self.find_or_create_by_authentication_hash(authentication_hash)
    user = User.find_or_initialize_by(github_user_id: authentication_hash[:uid])

    user.update_attributes!(
      github_username: authentication_hash[:info][:nickname],
      access_token: authentication_hash[:credentials][:token],
      name: authentication_hash[:info][:name],
      email: authentication_hash[:info][:email],
      avatar_url: authentication_hash[:info][:image],
    )

    user
  end
end
