require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReviewProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en

    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts" 
    config.to_prepare do
        Devise::SessionsController.layout "user"
    end
   end
end
