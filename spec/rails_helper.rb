require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require "factory_bot_rails"
require "faker"
require 'shoulda/matchers'

# Add Capybara and Selenium dependencies
require 'capybara/rspec'
require 'selenium/webdriver'
require 'webdrivers/chromedriver'

Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec', 'fixtures')

  config.use_transactional_fixtures = true

  # Include Capybara for feature (GUI) tests
  config.include Capybara::DSL, type: :system

  # Additional configuration for system tests
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  config.after(:each, type: :system, js: true) do
    Capybara.current_session.driver.quit
  end

  # Include other helpers as needed
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryBot::Syntax::Methods
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  config.include Warden::Test::Helpers, type: :request

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  # Setup shoulda-matchers
  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end

# Ensure ChromeDriver is available and up-to-date
Webdrivers::Chromedriver.required_version = '94.0.4606.61'

