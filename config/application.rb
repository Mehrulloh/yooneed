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

    Rails.application.config.paths.add "app/components", eager_load: true, glob: "*"

    config.time_zone = "Berlin"

    config.active_job.queue_adapter = :sidekiq
  end
end
