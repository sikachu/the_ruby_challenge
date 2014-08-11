Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, Rails.application.secrets['github']['client_id'],
    Rails.application.secrets['github']['secret'],
    scope: 'user:email'
end
