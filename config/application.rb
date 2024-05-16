require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProcurementV1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    config.eager_load_paths << Rails.root.join("lib")

    config.autoload_lib(ignore: %w(assets tasks))

    config.view_component.view_component_path = "app/components"

    config.eager_load_paths << Rails.root.join("app/components")

    config.time_zone = "Berlin"

    config.active_job.queue_adapter = :sidekiq
  end
end
