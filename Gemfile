#
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]

  # handle env vars in development
  gem 'dotenv-rails'
end

group :test do
  gem 'cuprite'
  gem "capybara"
  gem "simplecov", "~> 0.22.0"
  gem "simplecov-lcov", "~> 0.8.0"

  gem 'faker'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem "selenium-webdriver"
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 5.0'
  gem "database_cleaner-active_record", "~> 2.1"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

gem 'draper'
gem "sidekiq"
gem 'pg_search'
gem 'haml-rails'
gem "pg", "~> 1.1"
gem 'pundit', '~> 1.1'
gem "font-awesome-sass"
gem 'sass-rails', '>= 6'
gem "font-awesome-rails"
gem 'view_component', '~> 2.52'

# Devise
gem 'devise', '~> 4.8'

#AASM
gem 'aasm', '~> 5.1', '>= 5.1.1'