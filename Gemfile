source "https://rubygems.org"

ruby "2.1.5"

gem "airbrake"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "email_validator"
gem "delayed_job_active_record"
gem "daemons"
gem "flutie"
gem "i18n-tasks"
gem "jquery-rails"
gem "neat", "~> 1.5.1"
gem "newrelic_rpm"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rack-timeout"
gem "rails", "4.1.8"
gem "recipient_interceptor"
gem "sass-rails", "~> 4.0.3"
gem "simple_form"
gem "title"
gem "uglifier"
gem "hashie"
gem "unicorn"
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'haml-rails', '~> 0.8.2'
gem 'easypost', '~> 2.1.0'
gem 'money-rails', '~> 1.3.0'
gem "mini_magick"
gem "refile", require: ["refile/rails", "refile/image_processing"]
gem "font-awesome-rails"
gem "wysiwyg-rails"
gem 'kaminari', '~> 0.16.3'
gem 'clearance', '~> 1.8.1'
gem 'mandrill-api', '~> 1.0.53', require: "mandrill"

group :development do
  gem "bundler-audit"
  gem "spring"
  gem "spring-commands-rspec"
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.0.0"
end

group :test do
  gem "capybara-webkit", ">= 1.2.0"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
end

