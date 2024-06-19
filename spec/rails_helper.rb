require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "faker"
require 'rspec/rails'
require 'shoulda/matchers'
require "factory_bot_rails"
require 'database_cleaner/active_record'

# Add Capybara and Selenium dependencies
require 'capybara/rspec'
require 'selenium/webdriver'

Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

DatabaseCleaner.strategy = :truncation


RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.include Devise::Test::ControllerHelpers, type: :component
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include ViewComponent::TestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component
  config.include Warden::Test::Helpers, type: :controller
  config.include Warden::Test::Helpers, type: :feature
  config.include FactoryBot::Syntax::Methods
  config.include Rails.application.routes.url_helpers, type: :component
  config.include ApplicationHelper

  config.filter_run :focus
  config.use_transactional_fixtures = false
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding skip: true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:each, type: :feature) { Rails.application.load_seed }

  config.before(:each, type: :component) do
    @request = controller.request
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  # Setup shoulda-matchers
  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
