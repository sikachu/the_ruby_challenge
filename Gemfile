source "https://rubygems.org"
ruby "2.1.2"

gem "rails", "4.1.5"

gem "bcrypt", "~> 3.1.7"
gem "bugsnag"
gem "coffee-rails", "~> 4.0.0"
gem "jquery-rails"
gem "omniauth-github"
gem "pg"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "uglifier", ">= 1.3.0"
gem "unicorn"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.0.0"
  gem "shoulda-matchers", require: false
end

group :test do
  gem "capybara"
  gem "codeclimate-test-reporter", require: nil
  gem "rack_session_access"
end

group :production do
  gem "rails_12factor"
end
